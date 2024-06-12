import 'package:flutter/material.dart';

class PainScore extends StatefulWidget {
  const PainScore({super.key});

  @override
  State<PainScore> createState() => _PainScoreState();
}

class _PainScoreState extends State<PainScore> {
  double _value = 0;
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
            'Click to continue or stop exercise',
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color.fromRGBO(80, 194, 201, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {},
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
