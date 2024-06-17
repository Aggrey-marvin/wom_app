import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatefulWidget {
  final dynamic image;
  final dynamic name;

  const Home({super.key, required this.image, this.name});

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
      child:  Column(
        children: <Widget> [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 40, 0),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: MemoryImage(widget.image)
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black12,
                    )
                ),
                child: Column(
                  children: [
                    const Text(
                      "Knee Angle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      "70 degrees",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.cyan[900]
                      ),
                    ),
                  ],
                ),

              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black12,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total Steps ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "800 Steps",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.cyan[900]
                      ),
                    ),

                  ],
                ),

              ),
            ],
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
                )
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 2),
                  child: Text(
                    "HEALTH STATE",
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
          const SizedBox(height: 30),
          AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 1),
                        FlSpot(2, 1),
                        FlSpot(3, 4),
                        FlSpot(4, 5),
                        FlSpot(5, 2),
                      ],
                      color: Colors.cyan[900]
                  ),
                ],
              ),
            ),
          ),

        ],

      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            background,
            foreground,
          ],
        ),
      ),
    );
  }
}
