import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/widgets/notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: AppTextStyles.regular18.apply(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GetBuilder<NotificationController>(
          builder: (notiController) {
            if(notiController.notificationInProgress){
              return Center(child: CircularProgressIndicator(),);
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today',
                      style: AppTextStyles.regular18.apply(
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        notiController.markAllAsRead();
                      },
                      child: Text(
                        'Mark all as read',
                        style: AppTextStyles.regular14.apply(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 15.h),
                Expanded(
                  child: ListView.builder(
                    itemCount:notiController.notificationList.length,
                    itemBuilder: (context, index)
                    {
                      DateTime time = notiController.notificationList[index].createdAt;
                      String formattedTime = DateFormat('dd/MM/yyyy hh:mm a').format(time);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),

                        child: NotificationContainer(
                          time: formattedTime,
                          notiTitle: notiController.notificationList[index].title,
                          notiSubTitle:notiController.notificationList[index].content,
                          isRead: notiController.notificationList[index].isRead,
                          onDelete: () {notiController.getDeleteNotification(notiController.notificationList[index].id);},
                          onMarkAsRead: () {
                            notiController.markAsRead(
                              notiController.notificationList[index].id,
                            );
                          },
                        ),
                      );
                    }
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
