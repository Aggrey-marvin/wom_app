import 'package:flutter/material.dart';
import 'package:wom_app/pages/navigation_view.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool passwordVisible = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundShape.png"),
            fit: BoxFit.cover,
          ),
          color: Color.fromRGBO(196, 196, 196, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    'Welcome Back!'),
                const SizedBox(
                  height: 20.0,
                ),
                const Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  width: 500,
                  height: 250,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Create a password',
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },

                    ),
                  ),
                  obscureText: passwordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,

                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final orpc = OdooClient('http://138.201.186.0:8069/');
                    const String databaseName = 'wom-live';
                    String databaseAccessLogin = _email.text;
                    String databaseAccessPassword = _password.text;


                    try {
                      final session = await orpc.authenticate(databaseName,
                          databaseAccessLogin, databaseAccessPassword);


                      Map<String, dynamic> userValues = {
                        'user_id': session.userId,
                      };

                      var response = await orpc.callKw(
                        {
                          'model': 'patient',
                          'method': 'search_user',
                          'args': ['self', userValues],
                          'kwargs': {},
                        },
                      ).timeout(const Duration(seconds: 360));
                      
                      print("**************");
                      print(session);
                      print(response);
                      print("**************");

                      if ((response['success'])) {
                        response['password'] = databaseAccessPassword;
                        if(!context.mounted) return;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => NavigatorView(
                                  response: response,
                                  sessionData: session,
                                )));
                      } else {
                        await orpc.destroySession();
                        if(!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to log in. Please check your credentials.'),
                          )
                        );
                      }
                    } catch (e) {
                      if (e is OdooException) {
                        print(e.message); // Assuming OdooException has a property named 'message'
                      } else {
                        print(e);
                      }
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Hello odoo.'),
                      //     )
                      // );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(80, 194, 201, 1),
                    padding: const EdgeInsets.fromLTRB(40.0, 12.0, 40.0, 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      'Login'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                            'If new, Create an account ? '),
                        const SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/register');
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
