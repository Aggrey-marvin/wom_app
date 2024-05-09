from odoo import models

class ResUsersInherit(models.Model):
    _inherit = "res.users"

    def create_user(self, user_values):
        print("")
        print(user_values)
        print("")

        return "The thing worked"