import 'package:flutter/material.dart';

class ConnectBluetooth extends StatefulWidget {
  const ConnectBluetooth({super.key});

  @override
  State<ConnectBluetooth> createState() => _ConnectBluetoothState();
}

class _ConnectBluetoothState extends State<ConnectBluetooth> {
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

    Widget foreground = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const BlueScan()));
              Navigator.pushNamed(context, '/');
            },
            child: Icon(
              Icons.bluetooth,
              size: 60,
              color: Colors.cyan[900],
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Center(
          child: Text(
            'Please click to connect to Device',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Wearable Knee Monitor"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
      ),
    );
  }
}
