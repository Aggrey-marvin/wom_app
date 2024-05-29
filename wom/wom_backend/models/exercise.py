from odoo import fields, models

class Exercise(models.Model):
    _name = "exercise"
    _description = "Exercise"

    name = fields.Char(string="Excercise Name")
    expected_duration = fields.Integer(string="Expected Exercise duration")
    exercise_gif = fields.Binary(string="Exercise GIF")