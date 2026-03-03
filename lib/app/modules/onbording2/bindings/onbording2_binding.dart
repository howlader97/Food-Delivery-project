import 'package:get/get.dart';

import '../controllers/onbording2_controller.dart';

class Onbording2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Onbording2Controller>(
      () => Onbording2Controller(),
    );
  }
}
