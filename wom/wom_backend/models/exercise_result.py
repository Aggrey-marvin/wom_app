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