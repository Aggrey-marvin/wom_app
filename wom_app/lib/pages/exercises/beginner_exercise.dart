import 'package:flutter/material.dart';

class Beginner extends StatefulWidget {
  const Beginner({super.key});

  @override
  State<Beginner> createState() => _BeginnerState();
}

class _BeginnerState extends State<Beginner> {
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

    Widget foreground = const Text(
        'Hello, beginner page'
    );
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
      body: Stack(
        children: [
          background,
          foreground,
        ],
      )
    );
  }
}
