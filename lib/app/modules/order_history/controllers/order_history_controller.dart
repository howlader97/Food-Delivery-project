import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:get/get.dart';
import '../../../api_services/oder_delete_api_services/order_delete_api_service.dart';
import '../../../api_services/order_service/my_order.dart';
import '../../../api_services/utility/urls.dart';
import '../../../routes/app_pages.dart';
import '../models/my_order_model.dart';
import 'dart:async';

class OrderHistoryController extends GetxController {
  var isLoading = false.obs;
  var orderDetails = Rxn<OrderDetailsModel>();
  RxBool orderDeleteInProgress = false.obs;

  Future<void> fetchOrderDetails() async {
    try {
      isLoading(true);
      final data = await OrderService.getOrderDetails();

      if (data != null) {
        orderDetails.value = data;
        refresh();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> orderDeleteHistory(int orderId) async {
    orderDeleteInProgress.value = true;
    update();
    try {
      final response = await OrderDeleteApiService.orderDeleteApiRequest(
        Urls.orderDelete(orderId),
      );
      orderDeleteInProgress.value = false;

      if (response.statusCode == 204) {
        Get.snackbar('Success', 'Order Deleted successfully');
        await SharedPrefServices.saveIsCancelButtonTappedStatus(true);
        Get.offAllNamed(Routes.CUSTOM_BOTTOOM_BAR, arguments: {"index": 2});
      } else {
        update();
        Get.snackbar('Failed', response.body);
      }
    } catch (e) {
      orderDeleteInProgress.value = false;
      update();
      Get.snackbar('Failed', '$e');
    }
  }

  @override
  void onInit() {
    calledInit();
    super.onInit();
  }

  Future<void> calledInit() async {
    bool response = await SharedPrefServices.getIsCancelButtonTappedStatus();
    if (!response) {
      fetchOrderDetails();
    }
  }

  Timer? periodicTime;
  RxInt periodicRemainingTime = 30.obs;
  RxInt periodicRemainingMin = 0.obs;
  RxInt periodicRemainingSecond = 0.obs;
  RxBool isCancelButtonOn = false.obs;


  void periodicTimeFormating() {
    periodicRemainingMin.value = periodicRemainingTime.value ~/ 60;
    periodicRemainingSecond.value = periodicRemainingTime.value % 60;
    update();
  }

  void startPeriodicFunc() {
    periodicTime?.cancel();

    periodicRemainingTime.value = 30;
    periodicTimeFormating();

    isCancelButtonOn.value = true;

    periodicTime = Timer.periodic(const Duration(seconds: 1), (time) {
      if (periodicRemainingTime.value <= 0) {
        isCancelButtonOn.value = false;
        periodicTime?.cancel();
      } else {
        periodicRemainingTime.value--;
        periodicTimeFormating();
      }
    });
  }

  void clearTimer() {
    periodicTime?.cancel();
    periodicRemainingTime.value = 30;
    isCancelButtonOn.value = false;
  }
}
