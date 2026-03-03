import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/data/image_path.dart';
import 'package:al_khalifa/app/modules/history_page/views/ditails_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/history_page_controller.dart';

class HistoryPageView extends GetView<HistoryPageController> {
  const HistoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History'), centerTitle: true),
      body: GetBuilder<HistoryPageController>(
        builder: (historyController) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: historyController.historyModelList.length,
              itemBuilder: (context, index) {
                final historyData=historyController.historyModelList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Text(
                          'Order delivered',
                          style: AppTextStyles.bold15,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivered on',
                                  style: AppTextStyles.regular12,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4.0.h,
                                  ),
                                  child: Text(
                                    'Order summary',
                                    style: AppTextStyles.regular12,
                                  ),
                                ),
                                Text(
                                  'Total price paid',
                                  style: AppTextStyles.regular12,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${historyData.updatedAt}', style: AppTextStyles.bold12),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0.h),
                                child: Text(
                                  historyData.trxId,
                                  style: AppTextStyles.bold12,
                                ),
                              ),
                              Text('৳${historyData.totalAmount}', style: AppTextStyles.bold12),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.getDetailsHistoryData(historyData.id);
                             Get.to(() => DetailsHistoryPage(paymentHistoryModel: historyData,));
                          },
                          child: Text('See Details'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
