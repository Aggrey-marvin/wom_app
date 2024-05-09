import 'package:flutter/material.dart';
import 'package:wom_app/pages/exercises/exercise_model.dart';


class ExerciseCard extends StatelessWidget {

  final Exercise exercise;
  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      margin: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Ink.image(
            image: AssetImage(exercise.photo),
            height: 150,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.7), BlendMode.modulate),
            child: InkWell(
              onTap: () {
                if(exercise.name == "Beginner"){
                  Navigator.pushNamed(context, '/beginner');
                }
                else if(exercise.name == "Intermediate"){
                  Navigator.pushNamed(context, '/intermediate');
                }
                else {
                  Navigator.pushNamed(context, '/advanced');
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              exercise.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 8.0),
            child: Text(
              exercise.image,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
