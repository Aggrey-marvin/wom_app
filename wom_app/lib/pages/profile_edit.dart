import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

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
        fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the entire screen
      ),
    );

    Widget foreground = SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15.0,),
            const Center(
              child: CircleAvatar(
                radius: 45.0,
                backgroundImage: AssetImage(
                    "assets/images/profile.jpg"
                ),
              ),
            ),
            const SizedBox(height: 15.0,),
            InkWell(
              onTap: ( ){

              },
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
              child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your email',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your Height',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your Weight',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter your contact',
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                          backgroundColor: const Color.fromRGBO(80, 194, 201, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                      ),
                      child: const Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
              ),
            )
          ],
        )
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
