import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlexAngleNotifier extends StateNotifier<double> {
  FlexAngleNotifier() : super(0.0);

  void setStringValue(double value) {
    state = value;
  }
}

final flexAngleProvider = StateNotifierProvider<FlexAngleNotifier, double>(
        (ref) => FlexAngleNotifier()
);
