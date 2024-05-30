# -*- coding: utf-8 -*-
{
    'name': "wom",

    'summary': """
            Wearable Osteoarthritis System Backend
    """,

    'description': """
       The backend for the wearable Osteoarthritis System
    """,
    "license": "LGPL-3",
    'author': "BSE24-2",
    'website': "https://sites.google.com/view/wearableosteoarthritismonitor/home?authuser=0",
    'category': 'Uncategorized',
    'version': '0.1',
    'depends': [
        'base', 'muk_web_theme'    
    ],

    'data': [
        #--------security files--------#  
        'security/security.xml',
        'security/ir.model.access.csv',
        
        #------data files -------#

        #------report files -------#

        #----wizard files -------#
        
        #--------views--------#
        'views/patient_views.xml',
        'views/exercise_views.xml',
        'views/parameter_threshold_views.xml',
        'views/menus.xml',
        
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
