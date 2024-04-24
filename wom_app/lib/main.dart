import 'package:flutter/material.dart';
import 'package:wom_app/pages/login.dart';
import 'package:wom_app/pages/register.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/register',
  routes: {
    '/login': (context) => const Login(),
    '/register': (context) => const Register(),

  },
));


