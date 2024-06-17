import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepNotifier extends StateNotifier<double> {
  StepNotifier() : super(0.0);

  void setStringValue(double value) {
    state = value;
  }
}

final stepsProvider = StateNotifierProvider<StepNotifier, double>(
        (ref) => StepNotifier()
);