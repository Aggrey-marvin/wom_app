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