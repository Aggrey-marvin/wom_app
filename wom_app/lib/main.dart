import 'package:flutter/material.dart';
import 'package:wom_app/pages/home_page.dart';
import 'package:wom_app/pages/login.dart';
import 'package:wom_app/pages/navigationView.dart';
import 'package:wom_app/pages/profile_edit.dart';
import 'package:wom_app/pages/profile_page.dart';
import 'package:wom_app/pages/register.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/register',
  routes: {
    '/login': (context) => const Login(),
    '/register': (context) => const Register(),
    'navigator_view' : (context) => const NavigatorView(),
    '/home': (context) => const Home(),
    '/profile' : (context) => const Profile(),
    '/profile_edit' : (context) => const EditProfile(),

  },
));



