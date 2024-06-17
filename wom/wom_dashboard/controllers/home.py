# -*- coding: utf-8 -*-
import logging
from datetime import datetime, timedelta

from odoo import http
from odoo.http import request
from odoo.tools import lazy
from odoo.addons.auth_signup.controllers.main import AuthSignupHome
from odoo.addons.portal.controllers.portal import CustomerPortal
from odoo import http, SUPERUSER_ID, tools, _
from odoo.exceptions import ValidationError, UserError
from odoo.tools.json import scriptsafe as json_scriptsafe
import base64
import xmlrpc.client

_logger = logging.getLogger(__name__)


class MedicalPersonnelPortal(CustomerPortal):
    
    @http.route(['/my','/my/home'], auth='user')
    def home(self):
        qcontext = {}
        uid = request.session.uid

        patients = request.env['patient'].sudo().search_count([])
        active_patients = request.env['exercise.result'].search([
            ('create_date', '>', (datetime.now() - timedelta(days=20)))
        ]).mapped('patient_id')
        completed_sessions = request.env['exercise.result'].search([])
        recent_exercises = request.env['exercise.result'].search([], order="create_date DESC", limit=20)

        qcontext['patients'] = patients
        qcontext['active_patients'] = active_patients
        qcontext['completed_sessions'] = completed_sessions
        qcontext['recent_exercises'] = recent_exercises

        if uid:
            user = request.env['res.users'].sudo().browse(uid)
            qcontext['user'] = user

    
        return request.render('wom_dashboard.portal_my_home_inherit', qcontext)
    
    @http.route(['/my/transactions'], auth='user')
    def view_transactions(self):
        qcontext = {}
        uid = request.session.uid
        if uid:
            user = request.env['res.users'].sudo().search([('id','=',uid)])
            qcontext['user'] = user
            
        return request.render('wom_dashboard.portal_transactions',qcontext)
    
    @http.route(['/my/account'], auth='user')
    def view_account(self,*args,**kwargs):
        qcontext = {}
        uid = request.session.uid
        partner_id = False
        if uid:
            user = request.env['res.users'].sudo().search([('id','=',uid)])
            partner_id = user.partner_id.parent_id
            qcontext['has_letter'] = partner_id.has_letter
            qcontext['partner'] = partner_id
            qcontext['user'] = user
    
        if request.httprequest.method == 'POST' and kwargs.get('upload'):
            kwargs.pop('upload')
            model_record = request.env['ir.model'].sudo().search(
            [('model', '=', 'res.partner')])
            data = self.extract_data(model_record, kwargs)
            self.insert_attachment(
                    model_record, partner_id.id, data['attachments'])
            partner_id.write({'has_letter':True})
            qcontext['has_letter'] = partner_id.has_letter
            template = request.env.ref('kola_efris_frontend.letter_submitted_notification', raise_if_not_found=False)
            if template:
                template.sudo().send_mail(user.id, force_send=True)
           
        elif request.httprequest.method == 'POST' and 'save' in kwargs:
            kwargs.pop('save')
            kwargs['name'] = kwargs['first_name_edit']+" "+kwargs['last_name_edit']
            kwargs['email'] = kwargs.get('email_edit')
            kwargs['phone'] = kwargs.get('phone_edit')
            kwargs['vat'] = kwargs.get('vat_edit')
            kwargs.pop('first_name_edit')
            kwargs.pop('last_name_edit')
            kwargs.pop('email_edit')
            kwargs.pop('phone_edit')
            kwargs.pop('vat_edit')
            id = user.write(kwargs)
            if kwargs.get('vat'):
                partner_id.sudo().write({'vat': kwargs.get('vat')})
            if id:

                print('>>>>>>>>>>>>>>>>success')

          
        return request.render('wom_dashboard.portal_account',qcontext)
    