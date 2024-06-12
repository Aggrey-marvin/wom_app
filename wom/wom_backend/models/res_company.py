from odoo import fields, models

class ResCompanyInherit(models.Model):
    _inherit = "res.company"

    default_image = fields.Binary(string="Default Image")