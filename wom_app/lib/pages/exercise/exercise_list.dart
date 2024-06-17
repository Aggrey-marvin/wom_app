import 'package:flutter/material.dart';
import 'exercise_details.dart';
import 'exercise_item.dart';



class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key,  required this.exercises, this.response, this.sessionData});

  final dynamic response;
  final dynamic sessionData;

  final List<dynamic>  exercises;




  void selectExercise(BuildContext context, exercises){
    print('This is the dynamic list of $exercises');
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ExerciseDetails(exercise: exercises, response: response, sessionData: sessionData)));
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
        fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the entire screen
      ),
    );

    Widget content = ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context,index) => ExerciseItem(exercise: exercises[index],  onSelectExercise: (exercise){
          selectExercise(context, exercise);
        },)
    );

    if(exercises.isEmpty){
      content = const Center(
        child: Column(
          children: [
            Text("No exercises available..."),
          ],
        ),
      );
    }

    Widget foreground = SafeArea(
      child: content
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
