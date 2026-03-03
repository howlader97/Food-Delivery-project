import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class SearchBarController extends GetxController {
  final TextEditingController searchTEController = TextEditingController();

  final HomeController homeController = Get.find<HomeController>();

  @override
  void onClose() {
    searchTEController.dispose();
    super.onClose();
  }
}
