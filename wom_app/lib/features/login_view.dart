import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
          title: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Enter your Email"),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: "Enter your Password"),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                final orpc = OdooClient('http://localhost:8069/');
                const String databaseName = 'wom';
                try {
                  final session =
                      await orpc.authenticate(databaseName, email, password);
                  print(session);
                } on OdooException{
                  print("Access Denied. Wrong email or password.");
                }
              },
              child: const Text('Login'),
            ),
          ],
        ));
  }
}
