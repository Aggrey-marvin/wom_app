from odoo import fields, models

class ParameterThreshold(models.Model):
    _name = "parameter.threshold"
    _description = "Parameter Threshold"

    minimum_angle = fields.Float(string="Mininum Angle")
    maximum_angle = fields.Float(string="Maximum Angle")
    exercise_id = fields.Many2one("exercise", string="Exercise")
    