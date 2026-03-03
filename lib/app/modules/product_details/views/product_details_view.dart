import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';
import '../widgets/custom_stepper.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductDetailsView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          children: [
            CustomStepper(
              lowerLimit: 1,
              upperLimit: 10,
              stepValue: 1,
              initialValue: 1,
              onChange: (newValue) {
                print(newValue);
              },
            ),
          ]

        ),
      ),
    );
  }
}
