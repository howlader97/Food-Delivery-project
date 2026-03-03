import 'package:get/get.dart';

import '../controllers/search_bar_controller.dart';

class SearchBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchBarController>(
      () => SearchBarController(),
    );
  }
}
