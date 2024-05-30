from odoo import models

class ResUsersInherit(models.Model):
    _inherit = "res.users"

    def create_user(self, user_values):

        user_vals = {
            "name": user_values.get('name'),
            "login": user_values.get('login'),
            "password": user_values.get('password')
        }

        user = self.env['res.users'].create(user_vals)
        user.write({'groups_id': [(6,0,[self.env['res.groups'].search([('name', '=', 'Patient')]).id])]})

        patient_vals = {
            "user_id": user.id,
        }

        self.env['patient'].create(patient_vals)

        if user:
            return True
        else:
            return False