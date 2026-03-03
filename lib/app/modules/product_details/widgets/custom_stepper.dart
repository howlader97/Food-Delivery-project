
import 'package:al_khalifa/app/modules/product_details/controllers/stepper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';


class CustomStepper extends StatelessWidget {
  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final int initialValue;
  final Function(int) onChange;

  CustomStepper({
    super.key,
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.initialValue,
    required this.onChange,
  });

  final StepperController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.setup(
      lower: lowerLimit,
      upper: upperLimit,
      step: stepValue,
      initial: initialValue,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              _controller.decrement();
              onChange(_controller.value.value);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.black54,
                size: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${_controller.value}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              _controller.increment();
              onChange(_controller.value.value);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black54,
                size: 18,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
