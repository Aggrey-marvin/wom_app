from odoo import fields, models

class Patient(models.Model):
    _name = "doctor"
    _description = "Doctor Record"
    _order = "id DESC"

    user_id = fields.Many2one("res.user", string="Related User")