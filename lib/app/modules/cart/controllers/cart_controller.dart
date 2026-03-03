import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_services/cart_list_api_services/cart_list_api_services.dart';
import '../../../api_services/utility/urls.dart';
import '../models/cart_item_model.dart';

class CartController extends GetxController {
  bool cartInProgress = false;
  bool deleteInProgress = false;
  bool decreaseItemInProgress = false;

  List<CartItem> cartItemModelData = [];

  final quantities = <int, RxInt>{}.obs;

  double deliveryFee = 60;

  String money(num v) {
    final s = v.toString();
    final cleaned = s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
    return '$cleaned Tk';
  }

  double get subtotal {
    double sum = 0;

    for (final item in cartItemModelData) {
      final q = quantities[item.id]?.value ?? item.quantity;

      final double variationPrice =
      (item.variation.price is int)
          ? (item.variation.price as int).toDouble()
          : item.variation.price;

      sum += variationPrice * q;
    }

    return sum;
  }


  double get total => subtotal + deliveryFee;

  Future<bool> getCartListData() async {
    cartInProgress = true;
    update();
    try {
      final response = await CartListApiServices.cartListApiRequest(
        Urls.cartList,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List<dynamic>;
        cartItemModelData = decoded.map((e) => CartItem.fromJson(e)).toList();

        final currentIds = cartItemModelData.map((e) => e.id).toSet();

        for (final item in cartItemModelData) {
          quantities[item.id] = (item.quantity).obs;
        }
        quantities.removeWhere((key, _) => !currentIds.contains(key));

        update();
        update(['totals']);
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    } finally {
      cartInProgress = false;
      update();
    }
  }

  int qtyOf(int itemId) => quantities[itemId]?.value ?? 1;

  void increment(int itemId) {
    final q = quantities[itemId];
    if (q == null) return;
    q.value++;
    update(['item_$itemId', 'totals']);
  }

  void decrement(int itemId) {
    final q = quantities[itemId];
    if (q == null) return;
    if (q.value <= 1) {
      return;
    }

    q.value--;
    update(['item_$itemId', 'totals']);
  }

  void setFees({double? delivery, double? platform, double? vat}) {
    if (delivery != null) deliveryFee = delivery;
    update(['totals']);
  }

  void removeItem(int itemId) {
    cartItemModelData.removeWhere((e) => e.id == itemId);
    quantities.remove(itemId);
    update();
    update(['totals']);
  }

  @override
  void onInit() {
    super.onInit();
    getCartListData();
  }

  Future<void> deleteCartData(int cartId) async {
    deleteInProgress = true;
    update();

    try {
      final response = await CartListApiServices.deleteCartApiRequest(
        Urls.deleteCart(cartId),
      );

      deleteInProgress = false;

      if (response.statusCode == 200) {
        cartItemModelData.removeWhere((item) => item.id == cartId);

        update();
        //Get.snackbar('Success', 'Deleted from cart successfully');
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Deleted from cart successfully')),
        );
      } else {
        update();
        Get.snackbar('Failed', response.body);
      }
    } catch (e) {
      deleteInProgress = false;
      update();
      Get.snackbar('Failed', '$e');
    }
  }

  Future<void> decreaseCartItem(int cartId) async {
    decreaseItemInProgress = true;
    update();
    try {
      final response = await CartListApiServices.decreaseCartItemRequest(
        Urls.decreaseItem(cartId)
      );
      decreaseItemInProgress = false;
      update();
      if (response.statusCode == 201) {
        //  Get.snackbar('Success', 'Quantity successfully decrease');
      } else {
        Get.snackbar('Failed', response.body);
      }
    } catch (e) {
      decreaseItemInProgress = false;
      update();
      Get.snackbar('Failed', '$e');
    }
  }

  Future<void> increaseCartQuantity(int productId, int variationId) async {
    try {
      final response = await CartListApiServices.increaseCartQtyService(
        Urls.addCart,
        {
          "product_id": productId,
          "quantity": 1,
          "variation_id": variationId,
        },
      );

      if (response.statusCode == 201) {
        // Optional snackbar
        // Get.snackbar("Success", "Quantity increased");
      } else {
        Get.snackbar("Failed", response.body);
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }




}
