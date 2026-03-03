import 'package:al_khalifa/app/modules/cart/controllers/cart_controller.dart';
import 'package:al_khalifa/app/modules/checkout/model/order_model.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_services/order_service/order_service.dart';
import '../../cart/models/cart_item_model.dart';
import '../../order_history/controllers/order_history_controller.dart';

class CheckoutController extends GetxController {
  final orderHistoryController=Get.put(OrderHistoryController());
  final count = 1.obs;
  final selectedIndex = (-1).obs;
  TextEditingController addressController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final OrderService _orderService = OrderService();
  var isLoading = false.obs;

  Future<void> submitOrder({
    required List<CartItem> cartItems,
    required double subtotal,
    required double deliveryFee,
    required double total,
  }) async {
    try {
      isLoading(true);
      print("checkout controller is called");

      // Convert cart items to order items
      final orderItems = cartItems.map((cartItem) {
        return OrderItem(
          foodId: cartItem.productId,
          variationId: cartItem.variation.id
        ); // Use productId instead of id
      }).toList();

      // Create order request
      final orderRequest = OrderRequest(
        totalAmount: total,
        deliveryAddress: addressController.text.trim(),
        specialInstruction: instructionController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        orderItems: orderItems,
      );

      // Post to API
     bool response= await _orderService.postOrder(orderRequest);

      isLoading(false);

     if(response){
        final cartController =Get.find<CartController>();
        cartController.cartItemModelData.clear();
        cartController.quantities.clear();
        cartController.update();
       print("checkout controller called");

      // Get.snackbar('Success', 'Order placed successfully!');
       orderHistoryController.fetchOrderDetails();
       await SharedPrefServices.saveIsCancelButtonTappedStatus(false);
       orderHistoryController.startPeriodicFunc();
       Get.toNamed(Routes.CUSTOM_BOTTOOM_BAR,arguments: {"index":2});
     }else{

      // Get.snackbar('Failed', 'Order failed!');
     }
    } catch (e) {

    //  Get.snackbar('Error', 'Failed to place order: $e');
     // print('✅Order submission error: $e');
    } finally {
      isLoading(false);
    }
  }

  void select(int index) {
    selectedIndex.value = index;
  }

  void resetCheckout() {
    selectedIndex.value = -1;
    addressController.clear();
    instructionController.clear();
    phoneNumberController.clear();
  }


  void increment() {
    count.value++;
  }

  void decrement() {
    if (count > 1) {
      count.value--;
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    instructionController.dispose();
    super.onClose();
  }
}
