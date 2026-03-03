import 'package:get/get.dart';

import '../controllers/onbording1_controller.dart';

class Onbording1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Onbording1Controller>(
      () => Onbording1Controller(),
    );
  }
}
