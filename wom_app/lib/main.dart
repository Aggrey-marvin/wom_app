import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wom_app/pages/home_page.dart';
import 'package:wom_app/pages/login.dart';
import 'package:wom_app/pages/navigation_view.dart';
import 'package:wom_app/pages/profile_edit.dart';
import 'package:wom_app/pages/profile_page.dart';
import 'package:wom_app/pages/register.dart';

void main(){
  runApp(
    const ProviderScope(
      child: WomApp()
    )
  );
}

class WomApp extends StatefulWidget {
  const WomApp({super.key});

  @override
  State<WomApp> createState() => _WomAppState();
}

class _WomAppState extends State<WomApp> {


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/register',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        'navigator_view': (context) => const NavigatorView(
          response: {},
          sessionData: {},
        ),
        '/home': (context) => const Home(
          image: {},
        ),
        '/profile': (context) => const Profile(
          response: {},
          sessionData: {},
        ),
        '/profile_edit': (context) => const EditProfile(
          response: {},
          sessionData: {},
        ),

      },
    );
  }
}


