import 'package:flutter/material.dart';
import 'package:wom_app/pages/navigationView.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wearable Knee Monitor"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
        titleTextStyle: TextStyle(
          color: Colors.cyan[900],
          fontSize: 24,
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundShape.png"),
            fit: BoxFit.cover,
          ),
          color: Color.fromRGBO(196, 196, 196, 1),
        ) ,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                const Text(
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    'Welcome Back!'
                ),
                const SizedBox(height: 20.0,),
                const Image(
                  image: AssetImage('assets/images/logo.png', ),
                  width: 500,
                  height: 250,
                ),
                const SizedBox(height: 20.0,),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 20.0,),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Create a password',
                  ),
                ),
                const SizedBox(height: 20.0,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NavigatorView()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(80, 194, 201, 1),
                    padding: const EdgeInsets.fromLTRB(40.0, 12.0, 40.0, 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ) ,
                  child: const Text(
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      'Login'
                  ),
                ),
                const SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 8, 0, 0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                            style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                            ),
                            'If new, Create an account ? '
                        ),
                        const SizedBox(width: 20.0,),
                        InkWell(
                          onTap: ( ){
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ]

                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
