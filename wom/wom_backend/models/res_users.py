from odoo import models

class ResUsersInherit(models.Model):
    _inherit = "res.users"

    def create_user(self, user_values):
        print("")
        print(user_values)
        print("")

        user_vals = {
            "name": user_values.get('name'),
            "login": user_values.get('login'),
            "password": user_values.get('password')
        }

        user = self.env['res.users'].create(user_vals)

        if user:
            return True
        else:
            return False