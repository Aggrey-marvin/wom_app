import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:video_player/video_player.dart';
import 'package:wom_app/pages/exercise/pain_score.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.controller, required this.exercise});

  final VideoPlayerController controller;

  final exercise;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  Timer? timer;
  int counter = 0;
  int totalTime = 0;
  double _value = 20.0 ;

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter++;
      });
    });
  }

  void stopTimer(){
    setState(() => timer?.cancel());
    totalTime = counter;
    showPainScore();
    print(totalTime);
  }
  void showPainScore(){
    showModalBottomSheet(
        context: context,
        builder: (ctx) => const PainScore(),
        backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
    );
  }


  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.exercise.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900],
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 250,
                  child: SfRadialGauge(
                    axes: [
                      RadialAxis(
                        minimum: 0,
                        maximum: 160,
                        pointers: [
                          NeedlePointer(
                            value: 80,
                            enableAnimation: true,
                            needleColor: Colors.cyan[900],
                            knobStyle: KnobStyle(
                              color: Colors.cyan[900],
                            ),
                          ),
                        ],
                        // ranges: [
                        //   GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
                        //   GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
                        //   GaugeRange(startValue: 100, endValue: 160, color: Colors.red),
                        // ],
                        annotations: [
                          GaugeAnnotation(
                            widget: Text(
                              '80 °',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan[900]),
                            ),
                            positionFactor: 0.8,
                            angle: 80,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15.0), // Apply the same border radius here
                      child: AspectRatio(
                        aspectRatio: widget.controller.value.aspectRatio,
                        child: VideoPlayer(widget.controller),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 5,
                      left: 5,
                      right: 5,
                      bottom: 5,
                      child: IconButton(
                        icon: timer != null && timer!.isActive ? const Icon(null) : const Icon(Icons.play_arrow),
                        highlightColor: Colors.white24,
                        color: Colors.cyan[900],
                        iconSize: 60,
                        onPressed: () {
                          startTimer();
                        },
                      )
                  )
                ]),
                  Text(
                      'Time taken: $counter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[900],
                        fontSize: 25,
                      ),
                    ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    stopTimer();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        const Color.fromRGBO(80, 194, 201, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                    child: const Text(
                      'Done',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                    )
                ),

              ],
            ),
          )
        : const SafeArea(
            child: SizedBox(
              height: 800,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
  }
}
