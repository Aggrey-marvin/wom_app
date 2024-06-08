# -- coding: utf-8 --

from odoo import models

from odoo.http import request

class IrHttp(models.AbstractModel):
    _inherit = 'ir.http'

    def session_info(self):
        user = self.env.user
        session_uid = request.session.uid
        result = super(IrHttp, self).session_info()
        result.update({
            "company_id": user.company_id.id if session_uid else None,  # YTI TODO: Remove this from the user context
        })
        return result