import 'package:flutter/material.dart';

class Advanced extends StatefulWidget {
  const Advanced({super.key});

  @override
  State<Advanced> createState() => _AdvancedState();
}

class _AdvancedState extends State<Advanced> {
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
        'Hello, Advanced page'
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
