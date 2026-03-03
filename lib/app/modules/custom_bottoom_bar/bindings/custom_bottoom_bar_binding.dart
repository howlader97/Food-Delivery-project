import 'package:al_khalifa/app/modules/cart/controllers/cart_controller.dart';
import 'package:al_khalifa/app/modules/history_page/controllers/history_page_controller.dart';
import 'package:al_khalifa/app/modules/home/controllers/home_controller.dart';
import 'package:al_khalifa/app/modules/order_history/controllers/order_history_controller.dart';
import 'package:al_khalifa/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../checkout/controllers/checkout_controller.dart';
import '../controllers/custom_bottoom_bar_controller.dart';

class CustomBottomBarBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<CheckoutController>(() => CheckoutController());

    /*   Get.lazyPut<CustomBottomBarController>(
      () => CustomBottomBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
    );*/

    Get.put(CustomBottomBarController());
    Get.put(HomeController());
    Get.put(CartController());
    Get.put(OrderHistoryController());
    Get.put(ProfileController());
  }
}