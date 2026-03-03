import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await SharedPrefServices.getUserToken();
    await Future.delayed(const Duration(seconds: 2));
    if (await SharedPrefServices.isLoggedIn) {
      Get.offAllNamed(Routes.CUSTOM_BOTTOOM_BAR);
    } else {
      Get.offAllNamed(Routes.ONBORDING1);
    }
  }
}
