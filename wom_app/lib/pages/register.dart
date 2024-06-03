import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future createUser(String name, String email, String password,
      String confirmPassword) async {
    final orpc = OdooClient('http://192.168.18.43:8069/');
    const String databaseName = 'wom';
    const String databaseAccessLogin = 'admin';
    const String databaseAccessPassword = 'admin';
    var response;

    try {
      final session = await orpc.authenticate(
          databaseName, databaseAccessLogin, databaseAccessPassword);
      print(session);

      Map<String, dynamic> userValues = {
        'name': name,
        'login': email,
        'password': password,
        'confirm_password': confirmPassword
      };

      response = await orpc.callKw(
        {
          'model': 'res.users',
          'method': 'create_user',
          'args': ['self', userValues],
          'kwargs': {},
        },
      ).timeout(const Duration(seconds: 360));
      await orpc.destroySession();
    } on OdooException {
      response = false;
      print("Access Denied. Wrong email or password.");
    }
    return response;
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
                    'Welcome on Board!'),
                const SizedBox(
                  height: 20.0,
                ),
                const Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  width: 500,
                  height: 100,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Enter your full name',
                  ),
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
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _confirmPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Confirm password',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = _name.text;
                    final email = _email.text;
                    final password = _password.text;
                    final confirmPassword = _confirmPassword.text;

                    var response = await createUser(
                        name, email, password, confirmPassword);

                    print(response);

                    if (response == true) {
                      Navigator.pushNamed(context, '/login');
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
                      'Register'),
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
                            'Already have an account ? '),
                        const SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Login',
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
