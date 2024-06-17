import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:wom_app/pages/exercise/exercise_list.dart';

import '../providers/steps_provider.dart';


class PainScore extends ConsumerStatefulWidget {
  const PainScore(  {
    super.key, required this.minFlexAngle, required this.maxFlexAngle,
    this.exercise, required this.exerciseTime, this.response, this.sessionData,
  });

  final double minFlexAngle;
  final double maxFlexAngle;
  final dynamic exercise;
  final int exerciseTime;
  final dynamic response;
  final dynamic sessionData;

  @override
  ConsumerState<PainScore> createState() => _PainScoreState();
}

class _PainScoreState extends ConsumerState<PainScore> {
  double _value = 0;

  Future saveUserData(int userId, double minFlexAngle,
      double maxFlexAngle, double steps, double distance, double painScore,
      int exerciseTime, String exerciseName
      ) async{
    final orpc = OdooClient('http://138.201.186.0:8069/');
    const String databaseName = 'wom-live';
    String databaseAccessLogin = widget.sessionData.userLogin;
    String databaseAccessPassword = widget.response?['password'];
    var response;

    try {
      final session = await orpc.authenticate(
          databaseName, databaseAccessLogin, databaseAccessPassword);
      print(session);

      Map<String, dynamic> userData = {
        'userId' : userId,
        'minFlexAngle': minFlexAngle,
        'maxFlexAngle': maxFlexAngle,
        'steps': steps,
        'distance': distance,
        'painScore': painScore,
        'exerciseTime': exerciseTime,
        'exerciseName': exerciseName,
      };

      print('This is the user $userData');

      response = await orpc.callKw(
        {
          'model': 'exercise.result',//put your model
          'method': 'received_session_data',//put your method
          'args': ['self', userData],
          'kwargs': {},
        },
      ).timeout(const Duration(seconds: 360));
      await orpc.destroySession();
    } catch (e) {
      if (e is OdooException) {
        print('The error is ${e.message}'); // Assuming OdooException has a property named 'message'
      } else {
        print(e);
      }
    }
    return response;

  }

  @override
  Widget build(BuildContext context) {



    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'Record Pain Score',
            style: TextStyle(
              color: Colors.cyan[900],
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Please record your pain score',
            style: TextStyle(
              color: Colors.cyan[900],
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 40),
          Slider(
            min: 0.0,
            max: 10.0,
            value: _value,
            divisions: 10,
            thumbColor: Colors.cyan[900],
            activeColor: Colors.cyan[900],
            inactiveColor: Colors.white,
            label: '${_value.round()}',
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
          const SizedBox(height: 50),
          const Text(
            'Click Done to Complete Exercise Session',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(

                  onPressed: () async {

                    final double minFlexAngle = widget.minFlexAngle;
                    final double maxFlexAngle = widget.maxFlexAngle;
                    final dynamic exerciseName = widget.exercise['name'];
                    final int exerciseTime = widget.exerciseTime;
                    final int userId = widget.sessionData.userId;
                    final String userEmail = widget.sessionData.userLogin;
                    final double painScore = _value;
                    final String userPassword = widget.response?['password'];
                    final steps = ref.watch(stepsProvider);
                    final double distance = 0.0;

                    // Map<String, dynamic> userData = {
                    //   'userId' : userId,
                    //   'minFlexAngle': minFlexAngle,
                    //   'maxFlexAngle': maxFlexAngle,
                    //   'steps': steps,
                    //   'distance': distance,
                    //   'painScore': painScore,
                    //   'exerciseTime': exerciseTime,
                    //   'exerciseName': exerciseName,
                    // };
                    //
                    // print('This is the user data : $userData');


                    var response = await saveUserData(userId, minFlexAngle, maxFlexAngle,
                        steps, distance, painScore, exerciseTime, exerciseName
                    );

                    print('This is the exercise data $response');

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => ExerciseView(exercises: widget.response['exercises'],))
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color.fromRGBO(80, 194, 201, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  child: const Text(
                    'Complete',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
