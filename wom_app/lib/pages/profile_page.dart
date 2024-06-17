import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wom_app/pages/profile_edit.dart';

class Profile extends StatefulWidget {
  final dynamic response;
  final dynamic sessionData;

  const Profile({super.key, this.response,  this.sessionData});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

    Widget foreground = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 210,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black12,
                  )),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15.0,
                    ),
                    CircleAvatar(
                      radius: 45.0,
                      backgroundImage: MemoryImage(base64Decode(
                          widget.response['data']['photo'] as String)),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.response['data']['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[900],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  response: widget.response,
                                  sessionData: widget.sessionData,
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              const Color.fromRGBO(80, 194, 201, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Personal Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
              height: 360,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black12,
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Email :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  ${widget.sessionData.userLogin}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Gender :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  ${widget.response['data']['gender']}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Height :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  ${widget.response['data']['height']}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Weight :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  ${widget.response['data']['weight']}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
        body: Stack(
      children: [
        background,
        foreground,
      ],
    ));
  }
}
