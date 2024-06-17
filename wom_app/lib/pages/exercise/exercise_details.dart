import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wom_app/pages/exercise/video_player.dart';


class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({super.key, this.exercise, this.response, this.sessionData});

  final dynamic exercise;
  final dynamic response;
  final dynamic sessionData;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {

   late VideoPlayerController controller;

  @override
  void initState(){
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.exercise['exercise_gif']));
    controller.addListener(() => setState(() {}));
    controller.setLooping(true);
    controller.initialize().then((_) => controller.play());
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text("Wearable Knee Monitor"),
          titleTextStyle: TextStyle(
              color: Colors.cyan[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
      body:Stack(
          children: [
            // background,
            VideoPlayerWidget(controller: controller, exercise: widget.exercise, response: widget.response, sessionData: widget.sessionData),
          ],
      )
    );
  }
}

