from odoo import fields, models

class ParameterThreshold(models.Model):
    _name = "parameter.threshold"
    _description = "Parameter Threshold"

    minimum_angle = fields.Float(string="Minimum Angle")
    normal_flexion_range = fields.Float(string="Normal Flexion Range")
    minimum_age = fields.Integer(string="Mininum Age")
    maximum_age = fields.Integer(string="num Age")