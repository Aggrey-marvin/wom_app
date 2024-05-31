import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final image;

  const Home({super.key, required this.image});

  @override
  State<Home> createState() => _WomHomeState();
}

class _WomHomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
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

    Widget foreground = SafeArea(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 30.0,
            backgroundImage: MemoryImage(widget.image),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black12,
                )),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                  child: Text(
                    "RANGE OF MOTION",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(55.0, 10.0, 0.0, 10.0),
                      child: Text("5"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 55.0, 10.0),
                      child: Text("125"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(55.0, 0.0, 0.0, 15.0),
                      child: Text("Min"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 55.0, 15.0),
                      child: Text("Max"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black12,
                )),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 2),
                  child: Text(
                    "VERDICT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "You have a normal functional range of motion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          background,
          foreground,
        ],
      ),
    );
  }
}
