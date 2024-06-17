from datetime import datetime, timedelta

from odoo import fields, models

class Patient(models.Model):
    _name = "patient"
    _description = "patient Record"
    _order = "id DESC"

    user_id = fields.Many2one("res.users", string="Related User")
    name = fields.Char(related="user_id.name", string="Name")
    email = fields.Char(related="user_id.login", string="Email")
    address = fields.Char(string="Address")
    date_of_birth = fields.Date(string="Date of Birth")
    profile_picture = fields.Binary(string="Profile Picture")
    doctor_id = fields.Many2one("doctor", string="Doctor")
    gender = fields.Selection(selection=[
        ('male', 'Male'),
        ('female', 'Female')
    ], string="Gender")
    height = fields.Float(string="Height")
    weight = fields.Float(string="Weight")
    state = fields.Selection(selection=[
        ('active', 'Active'),
        ('in_active', 'Inactive'),
    ], string="Status", default="in_active")
    age = fields.Integer(string="Age")

    def search_user(self, vals):
        patient = self.env['patient'].search([('user_id', '=', vals.get('user_id'))])
        if patient:
            patient_dict = {
                'success': True,
                'data': {
                'photo': patient.profile_picture if patient.profile_picture else self.env.company.default_image,
                'gender': str(patient.gender).capitalize(),
                'height': str(patient.height),
                'weight': str(patient.weight),
                'name': patient.user_id.name,
                'contact': str(patient.user_id.phone)
                }
            }

            exercises = self.env['exercise'].search([])
            exercise_list = []

            for exercise in exercises:
                exercise_list.append({
                    'name': exercise.name,
                    'expected_duration': exercise.expected_duration,
                    'exercise_gif': exercise.exercise_gif,
                    'exercise_image': exercise.exercise_image,
                    'exercise_id': exercise.id
                })

            # Getting past exercise records
            pass_exercise_data = self.env['exercise.result'].search([
                    ('patient_id', '=', patient.id),
                    ('create_date', '>', (datetime.now() - timedelta(days=30)).strftime('%Y-%m-%d %H:%M:%S'))
                ], order="create_date ASC")
            
            most_recent_exercise_data = self.env['exercise.result'].search([
                    ('patient_id', '=', patient.id),
                    ('create_date', '>', (datetime.now() - timedelta(days=30)).strftime('%Y-%m-%d %H:%M:%S'))
                ], order="create_date DESC", limit=1)
            
            # Getting the verdict
            patient_age = patient.age
            parameter_threshold = self.env['parameter.threshold'].search([
                ('minimum_age', '<', patient_age),
                ('maximum_age', '>', patient_age),
            ], limit=1, order="create_date DESC")

            verdict = None
            flex_range = most_recent_exercise_data.highest_angle - most_recent_exercise_data.lowest_angle

            if parameter_threshold:
                if vals.get('minFlexAngle') >= most_recent_exercise_data.lowest_angle and\
                    vals.get('minFlexAngle') <= (most_recent_exercise_data.lowest_angle + 5) and\
                        flex_range >= (parameter_threshold.normal_flexion_range - 5) and\
                            flex_range >= (parameter_threshold.normal_flexion_range - 5):
                    verdict = "veryGood"
                elif not (vals.get('minFlexAngle') >= most_recent_exercise_data.lowest_angle and\
                    vals.get('minFlexAngle') <= (most_recent_exercise_data.lowest_angle + 5)) and\
                        flex_range >= (parameter_threshold.normal_flexion_range - 5) and\
                            flex_range >= (parameter_threshold.normal_flexion_range - 5):
                    verdict = "good"
                elif not (vals.get('minFlexAngle') >= most_recent_exercise_data.lowest_angle and\
                    vals.get('minFlexAngle') <= (most_recent_exercise_data.lowest_angle + 5)) and\
                        not (flex_range >= (parameter_threshold.normal_flexion_range - 5) and\
                            flex_range >= (parameter_threshold.normal_flexion_range - 5)):
                    verdict = "fair"
            
            flutter_exercise_data = []

            for data in pass_exercise_data:
                flutter_exercise_data.append({
                    "date": data.create_date,
                    "painScore": data.pain_score,
                    "maxFlexAngle": data.highest_angle,
                    "minFlexAngle": data.lowest_angle,
                    "exerciseTime": data.time,
                    "steps": data.steps,
                    "distance": data.exercise_duration
                })

            patient_dict['exercises'] = exercise_list
            patient_dict['previousData'] = flutter_exercise_data
            patient_dict['verdict'] = verdict
            return patient_dict
        else:
            return {
                 'success': False,
                 'data': {}
             }

    def edit_user_details(self, vals):
        patient = self.env['patient'].search([('user_id', '=', int(vals['user_id']))])
        updated_patient_values = {
            'height': vals.get('height'),
            'weight': vals.get('weight'),
        }

        updated_user_values = {
            'phone': vals.get('contact'),
            'login': vals.get('email'),
        }

        patient.sudo().write(updated_patient_values)
        patient.sudo().user_id.write(updated_user_values)

        patient_dict = {
            'success': True,
            'data': {
                'photo': patient.profile_picture,
                'gender': str(patient.gender).capitalize(),
                'height': str(patient.height),
                'weight': str(patient.weight),
                'name': patient.user_id.name,
                'contact': str(patient.user_id.phone)
            }
        }
        return patient_dict
    

    # --------------------------------------------------------------------------------------------------
    #                                   CRON METHODS    
    # --------------------------------------------------------------------------------------------------

    def cron_update_patient_status(self):
        for patient in self.search([]):
            exercise_session = self.env['exercise.result'].search([
                ('patient_id', '=', patient.id),
                ('create_date', '>', (datetime.now() - timedelta(days=20))),
            ])

            if len(exercise_session) > 0:
                patient.write({
                    'state': 'active'
                })
            else: 
                patient.write({
                    'state': 'in_active'
                })
        print("")
        print("self", self.search([]))
        print("")