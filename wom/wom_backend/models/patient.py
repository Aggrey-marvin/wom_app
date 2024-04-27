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
