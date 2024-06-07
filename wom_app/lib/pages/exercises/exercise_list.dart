import 'package:flutter/material.dart';

import '../model/exercise_model.dart';
import 'exercise_details.dart';
import 'exercise_item.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key, required this.exercises});

  final List<Exercise> exercises;

  void selectExercise(BuildContext context, Exercise exercise) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ExerciseDetails(
        exercise: exercise,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget background = SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Image.asset(
        'assets/images/backgroundShape.png',
        fit: BoxFit
            .cover, // Use BoxFit.cover to ensure the image covers the entire screen
      ),
    );

    Widget content = ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) => ExerciseItem(
              exercise: exercises[index],
              onSelectExercise: (exercise) {
                selectExercise(context, exercise);
              },
            ));

    if (exercises.isEmpty) {
      content = const Center(
        child: Column(
          children: [
            Text("No exercises available..."),
          ],
        ),
      );
    }

    Widget foreground = SafeArea(child: content);

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
