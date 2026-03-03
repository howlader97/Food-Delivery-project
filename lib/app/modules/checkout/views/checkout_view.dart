import 'package:al_khalifa/app/modules/checkout/views/payment_method.dart';
import 'package:al_khalifa/app/modules/common/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_text_styles.dart';
import '../../cart/models/cart_item_model.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final List<CartItem> cartModelData = arguments['cart_model_data'];
    final subtotal = arguments['subtotal'];
    final deliveryFee = arguments['delivery_fee'];
    final total = arguments['total'];
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxBodyWidth = 680.0;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxBodyWidth),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivery Address', style: AppTextStyles.medium18),
                      SizedBox(height: 12.h),
                      TextFormField(
                        controller: controller.addressController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          hintText: 'Enter your adress',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Special Instructions',
                        style: AppTextStyles.medium18,
                      ),
                      SizedBox(height: 12.h),
                      TextFormField(
                        controller: controller.instructionController,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter your instructions',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Enter Contact Number',
                        style: AppTextStyles.medium18,
                      ),
                      SizedBox(height: 12.h),
                      TextFormField(
                        controller: controller.phoneNumberController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.phone),
                          hintText: 'Enter your phone Number',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text('Payment Method', style: AppTextStyles.medium18),
                      SizedBox(height: 8.h),
                      PaymentMethod(paymentWay: "Cash on Delivery", index: 0),
                      PaymentMethod(paymentWay: "Bkash", index: 1),
                      SizedBox(height: 16.h),
                      Text('Order Summary', style: AppTextStyles.medium18),
                      SizedBox(height: 8.h),
                      for (int i = 0; i < cartModelData.length; i++)
                        CustomList(
                          chargeType:
                              '${cartModelData[i].quantity}x ${cartModelData[i].food.name}',
                          amount:
                              '${cartModelData[i].quantity * cartModelData[i].variation.price} Tk',
                        ),
                      SizedBox(height: 8.h),
                      Divider(height: 24.h, thickness: 1),
                      CustomList(
                        chargeType: 'Subtotal',
                        amount: '$subtotal Tk',
                      ),
                      CustomList(
                        chargeType: 'Delivery Fee',
                        amount: '$deliveryFee Tk',
                      ),
                      SizedBox(height: 8.h),
                      Divider(height: 24.h, thickness: 1),
                      CustomList(chargeType: 'Total', amount: '$total Tk'),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              if (controller.addressController.text.isEmpty &&
                                  controller
                                      .phoneNumberController
                                      .text
                                      .isEmpty &&
                                  controller
                                      .instructionController
                                      .text
                                      .isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Please enter the all required field',
                                  animationDuration: Duration(
                                    milliseconds: 300,
                                  ),
                                );
                              } else {
                                controller.submitOrder(
                                  cartItems: cartModelData,
                                  subtotal: subtotal,
                                  deliveryFee: deliveryFee,
                                  total: total,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  controller.selectedIndex.value < 0 ||
                                      controller.addressController.text.isEmpty
                                  ? Colors.white
                                  : null,
                              foregroundColor:
                                  controller.selectedIndex.value < 0 ||
                                      controller.addressController.text.isEmpty
                                  ? Colors.black
                                  : null,
                            ),
                            child: Text(
                              'Checkout',
                              style: AppTextStyles.medium18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
