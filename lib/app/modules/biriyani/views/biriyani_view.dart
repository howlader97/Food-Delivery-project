import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/biriyani_controller.dart';

class BiriyaniView extends GetView<BiriyaniController> {
  const BiriyaniView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiriyaniView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BiriyaniView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
