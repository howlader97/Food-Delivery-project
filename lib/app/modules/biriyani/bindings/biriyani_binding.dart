import 'package:al_khalifa/app/modules/biriyani/controllers/biriyani_controller.dart';
import 'package:get/get.dart';


class BiriyaniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiriyaniController>(
          () => BiriyaniController(),
    );
  }
}
