import 'package:get/get.dart';

class StepperController extends GetxController {
  late int lowerLimit;
  late int upperLimit;
  late int stepValue;
  RxInt value = 1.obs;

  void setup({
    required int lower,
    required int upper,
    required int step,
    required int initial,
  }) {
    lowerLimit = lower;
    upperLimit = upper;
    stepValue = step;
    value.value = initial;
  }

  void increment() {
    if (value.value + stepValue <= upperLimit) {
      value.value += stepValue;
    }
  }

  void decrement() {
    if (value.value - stepValue >= lowerLimit) {
      value.value -= stepValue;
    }
  }
}