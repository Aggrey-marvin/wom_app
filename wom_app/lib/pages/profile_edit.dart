import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:wom_app/pages/profile_page.dart';
import 'dart:convert';

class EditProfile extends StatefulWidget {
  final response;
  final sessionData;

  const EditProfile(
      {super.key, required this.response, required this.sessionData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Text editing controllers
  late final TextEditingController _email;
  late final TextEditingController _height;
  late final TextEditingController _weight;
  late final TextEditingController _contact;

  @override
  void initState() {
    _email = TextEditingController(text: widget.sessionData.userLogin);
    _height = TextEditingController(text: widget.response['data']['height']);
    _weight = TextEditingController(text: widget.response['data']['weight']);
    _contact = TextEditingController(text: widget.response['data']['contact']);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _height.dispose();
    _weight.dispose();
    _contact.dispose();
    super.dispose();
  }

  Future editUserDetails(String height, String email, String weight,
      String contact, String password) async {
    final orpc = OdooClient('http://192.168.18.43:8069/');
    String databaseName = "wom";
    var response;

    try {
      final session = await orpc.authenticate(databaseName, email, password);

      Map<String, dynamic> userValues = {
        'height': height,
        'email': email,
        'weight': weight,
        'contact': contact,
        'user_id': widget.sessionData.userId
      };

      response = await orpc.callKw(
        {
          'model': 'patient',
          'method': 'edit_user_details',
          'args': ['self', userValues],
          'kwargs': {},
        },
      ).timeout(const Duration(seconds: 360));

      if (response['success']) {
        response['sessionData'] = session;
        response = response;
      }
    } on OdooException {
      response = false;
      print("An error occured.");
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Create a background image that covers the entire screen
    Widget background = SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Image.asset(
        'assets/images/backgroundShape.png',
        fit: BoxFit
            .cover, // Use BoxFit.cover to ensure the image covers the entire screen
      ),
    );

    Widget foreground = SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          Center(
            child: CircleAvatar(
                radius: 45.0,
                backgroundImage: MemoryImage(
                    base64Decode(widget.response['data']['photo'] as String))),
          ),
          const SizedBox(
            height: 15.0,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Change Picture',
              style: TextStyle(
                color: Colors.lightBlue[800],
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _height,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Enter your Height',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _weight,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Enter your Weight',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _contact,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Enter your contact',
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () async {
                  var response = await editUserDetails(
                    _height.text,
                    _email.text,
                    _weight.text,
                    _contact.text,
                    widget.response['password'],
                  );
                  if (response['success']) {
                    response['password'] = widget.response['password'];
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Profile(
                              response: response,
                              sessionData: response['sessionData'],
                            )));
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 10.0),
                    backgroundColor: const Color.fromRGBO(80, 194, 201, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                child: const Text(
                  "Update Profile",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          )
        ],
      )),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.cyan[900],
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          background,
          foreground,
        ],
      ),
    );
  }
}
