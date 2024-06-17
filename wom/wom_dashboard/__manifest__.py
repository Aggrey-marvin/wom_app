# -*- coding: utf-8 -*-
{
    'name': "wom_dashboard",

    'summary': """
            Wearable Osteoarthritis System Dashboard
    """,

    'description': """
       The backend for the wearable Osteoarthritis System Dashboard
    """,
    "license": "LGPL-3",
    'author': "BSE24-2",
    'website': "https://sites.google.com/view/wearableosteoarthritismonitor/home?authuser=0",
    'category': 'Uncategorized',
    'version': '0.1',
    'depends': [
        'base'   
    ],

    'data': [
        #--------security files--------#
        
        #------data files -------#

        #------report files -------#

        #----wizard files -------#
        
        #--------views--------#
        'views/portal/portal_transactions.xml',
        'views/portal/portal_nav.xml',
        'views/portal/portal_my_account.xml',
        'views/portal/portal_header.xml',
        'views/portal/portal_dashboard.xml',
        'views/portal/portal_assets.xml',
        
    ],

    "assets": {
        "web.assets_backend": [
            
           
        ],
        "web.assets_qweb": [
        
        ],
        
    },
    
    'images':[
        
    ],
}
