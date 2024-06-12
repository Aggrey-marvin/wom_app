import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';


class ExerciseItem extends StatelessWidget {
  const ExerciseItem({super.key, required this.exercise, required this.onSelectExercise});

  final exercise;
  final void Function(Exercise exercise) onSelectExercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: InkWell(
        onTap: (){
          onSelectExercise(exercise);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image:  AssetImage(exercise.thumbnail),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      exercise.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, //cuts off long text
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [

                      ],
                    )
                  ],
                ),

              ),
            ),

          ]
        ),
      ),
    );
  }
}
