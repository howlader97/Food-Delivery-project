
import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/data/image_path.dart';
import 'package:al_khalifa/app/modules/order_history/models/my_order_model.dart';
import 'package:al_khalifa/app/modules/profile/controllers/profile_controller.dart';
import 'package:al_khalifa/app/widgets/location_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  OrderHistoryView({super.key});
  final data = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final OrderDetailsModel? orderDetailsModel = controller.orderDetails.value;

          return RefreshIndicator(
            onRefresh: ()async{
              await controller.calledInit();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                SizedBox(height: 20.h),
                if(controller.isLoading.value)
                  Center(child: CircularProgressIndicator())
                else if (orderDetailsModel == null)
                // Show loading or empty state with proper height
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Image.asset(ImagePath.noProduct,scale: 1,),
                        Text('No orders yet',style: AppTextStyles.medium24,),
                        Text('Your order history is empty. Start exploring delicious meals from restaurants near you!',style: AppTextStyles.regular14,),
                      ],
                    )
                  )
                else
                // Show order content
                  ..._buildOrderContent(orderDetailsModel),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildOrderContent(OrderDetailsModel orderDetails) {
    return [
      Text('Order Item', style: AppTextStyles.medium18),
      SizedBox(height: 10.h),

      ...orderDetails.orderItems.map((item) {
        return Card(
          child: Container(
            color: AppColors.greyLightColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.network(
                        item.food.foodImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) =>
                        const Icon(Icons.fastfood, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.food.name,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '৳ ${item.variation.price}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          orderDetails.deliveryAddress,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),

      SizedBox(height: 20.h),
      Text('Order Details', style: AppTextStyles.medium18),
      SizedBox(height: 10.h),
      CustomRichText(title: 'Order number: ${orderDetails.id}', text: ''),
      SizedBox(height: 10.h),
      CustomRichText(
        showIcon: true,
        text:
        '${orderDetails.deliveryAddress}, ${orderDetails.deliveryFullAddress}',
      ),
      SizedBox(height: 10.h),
      Text('Total: TK ${orderDetails.totalAmount}',
          style: AppTextStyles.medium24),
      SizedBox(height: 20.h),
      Center(
        child: Text(
          'Got Your Order: '
              '${data.profileModelInfo.value.firstName} '
              '${data.profileModelInfo.value.lastName}',
          style: AppTextStyles.medium18,
        ),
      ),
      SizedBox(height: 20.h),
      Text(
        'Once the order is confirmed by you, we will start preparing it.',
        style: AppTextStyles.regular14,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20.h),
      Obx(() {
        if (controller.isCancelButtonOn.value) {
          // Still within 5 minutes — show countdown + cancel button
          return Column(
            children: [
              Text(
                'You can cancel your order within: ${controller.periodicRemainingMin}:${controller.periodicRemainingSecond}',
                style: AppTextStyles.medium12,
              ),
              SizedBox(height: 10.h),
              CustomElevatedButton(
                onPressed: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) => AlertDialog(
                      title: const Text('Cancel your order?'),
                      actions: [
                        Column(
                          spacing: 10.h,
                          children: [
                            Text(
                              'Do you really want to cancel the order?',
                              style: AppTextStyles.regular14,
                            ),
                            Obx(()=>controller.isCancelButtonOn.value?SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.orderDeleteHistory(orderDetails.id);
                                },
                                child: const Text('Cancel my order'),
                              ),
                            ):SizedBox()),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'I\'ll wait for the rider',
                                  style: AppTextStyles.regular14
                                      .apply(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );


                },
                text: 'Cancel',
              ),
            ],
          );
        } else {
          // After 5 minutes — show Pending status
          return Column(
            children: [
              Text(
                orderDetails.status,
                style: AppTextStyles.medium18.copyWith(color: Colors.orange),
              ),
              SizedBox(height: 10.h),
              Text(
                'You can no longer cancel this order.',
                style: AppTextStyles.regular14,
              ),
            ],
          );
        }
      }),


    ];
  }
}