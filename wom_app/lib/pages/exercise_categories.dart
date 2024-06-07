// import 'package:flutter/material.dart';
//
// import 'exercises/exercise_card.dart';
// import 'exercises/exercise_model.dart';
//
//
// class ExerciseCategory extends StatefulWidget{
//   const ExerciseCategory({super.key, required});
//
// @override
// State<ExerciseCategory> createState() => _ExerciseCategoryState();
// }
//
// class _ExerciseCategoryState extends State<ExerciseCategory> {
//
//   List<Exercise> exercises = [
//     Exercise("Beginner", "20 Mins 3 Exercises", "assets/images/beginner.jpg"),
//     Exercise("Intermediate", "35 Mins 3 Exercises", "assets/images/intermediate.jpg"),
//     Exercise("Advanced", "37 Mins 3 Exercises", "assets/images/advanced.jpg"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the screen dimensions
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     // Create a background image that covers the entire screen
//     Widget background = SizedBox(
//       width: screenWidth,
//       height: screenHeight,
//       child: Image.asset(
//         'assets/images/backgroundShape.png',
//         fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the entire screen
//       ),
//     );
//
//     Widget foreground = SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Center(
//                 child: Text(
//                   'Categories of Exercises',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               ...exercises.map((exercise) => ExerciseCard(exercise: exercise)),
//             ],
//           ),
//         ),
//       ),
//     );
//
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           background,
//           foreground,
//         ],
//       ),
//     );
//   }
// }