import 'package:flutter/material.dart';
import 'package:wom_app/pages/exercise_categories.dart';
import 'package:wom_app/pages/exercises/advanced_exercise.dart';
import 'package:wom_app/pages/exercises/beginner_exercise.dart';
import 'package:wom_app/pages/exercises/intermediate_exercise.dart';
import 'package:wom_app/pages/home_page.dart';
import 'package:wom_app/pages/login.dart';
import 'package:wom_app/pages/navigationView.dart';
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
    '/exercise_categories' : (context) => const ExerciseCategory(),
    '/beginner' : (context) => const Beginner(),
    '/intermediate' : (context) => const Intermediate(),
    '/advanced' : (context) => const Advanced(),

  },
));



