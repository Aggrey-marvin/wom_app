from datetime import datetime, timedelta

from odoo import fields, models

class ExcerciseResult(models.Model):
    _name = "exercise.result"

    lowest_angle = fields.Float(string="Lowest Angle")
    highest_angle = fields.Float(string="Highest Angle")
    average_angle = fields.Float(string="Average Angle")
    standard_deviation = fields.Float(string="Standard Deviation")
    time = fields.Integer(string="Time")
    exercise_id = fields.Many2one("exercise", string="Exercise")
    pain_score = fields.Float(string="Pain Score")
    patient_id = fields.Many2one('patient', string="Patient")
    steps = fields.Integer(string="Steps")
    distance = fields.Float(string="Distance Moved")
    exercise_duration = fields.Float(string="Exericse Duration")

    def received_session_data(self, vals):
        patient = self.env['patient'].search([('user_id', '=', vals.get('userId'))])

        if patient:
            exercise_data = {
                "lowest_angle": vals.get('minFlexAngle'),
                "highest_angle": vals.get('maxFlexAngle'),
                "patient_id": patient.id,
                "steps": vals.get('steps'),
                "distance": vals.get('distance'),
                "pain_score": vals.get('painScore'),
                "exercise_duration": vals.get('exerciseTime'),
                "exercise_id": vals.get('exerciseId')
            }

            self.create(exercise_data)

            # Getting past exercise records
            pass_exercise_data = self.env['exercise.result'].search([
                    ('patient_id', '=', patient.id),
                    ('create_date', '>' (datetime.now() - timedelta(days=30)))
                ], order="create_date ASC")
            
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

            return {
                "success": True,
                "data": flutter_exercise_data
            }
        
        else:
            return {
                "success": False,
                "data": []
            }
        