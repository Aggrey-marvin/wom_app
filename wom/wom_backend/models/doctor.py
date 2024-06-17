from odoo import fields, models

class Doctor(models.Model):
    _name = "doctor"
    _description = "Doctor"
    _order = "id DESC"

    user_id = fields.Many2one("res.user", string="Related User")