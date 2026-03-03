/*
import 'dart:convert';

import 'package:al_khalifa/app/api_services/utility/urls.dart';
import 'package:al_khalifa/app/modules/notification/model/notification_model.dart';
import 'package:get/get.dart';

import '../../../api_services/notifications/all_notifications.dart';
import 'package:get_storage/get_storage.dart';


class NotificationController extends GetxController {
  final box = GetStorage();
  bool notificationInProgress=false;
  bool deleteNotificationInProgress=false;
  List<NotificationModel> notificationList=[];
  @override
  void onInit() {
    getAllNotification();
    super.onInit();
  }
  Future<bool> getAllNotification()async{
    notificationInProgress=true;
    update();
    try{
      final response=await Notifications.getNotificationRequest(Urls.notification);
      notificationInProgress=false;
      print(response.body);
      if(response.statusCode == 200){
        List<dynamic> decodedResponse=jsonDecode(response.body);
        notificationList=decodedResponse.map((e) => NotificationModel.fromJson(e)).toList();
        update();
        return true;
      }else{
        update();
        return false;
      }
    }catch(e){
      notificationInProgress=false;
      update();
      print("error is $e");
      return false;
    }
  }

  Future<void> getDeleteNotification(int notificationId)async{
    deleteNotificationInProgress=true;
    update();
    try{
      final response=await Notifications.deleteNotificationRequest(Urls.deleteNotificationById(notificationId));
      deleteNotificationInProgress=false;
      update();
      if(response.statusCode == 204){
        getAllNotification();
      }else{
        Get.snackbar('Failed', 'problem is ${response.body}');
      }

    }catch(e){
      deleteNotificationInProgress=false;
      update();
      Get.snackbar('Error', '$e');
    }
  }

  void markAsRead(int id) {
    final index = notificationList.indexWhere((n) => n.id == id);
    if (index != -1 && notificationList[index].isRead == false) {
      // create a new instance with isRead = true because fields are final
      notificationList[index] = NotificationModel(
        title: notificationList[index].title,
        content: notificationList[index].content,
        image: notificationList[index].image,
        id: notificationList[index].id,
        isRead: true,
        createdAt: notificationList[index].createdAt,
        updatedAt: DateTime.now(), // or keep previous updatedAt if you want
      );
      update();
    }
  }

  /// Mark all notifications as read locally
  void markAllAsRead() {
    bool changed = false;
    for (int i = 0; i < notificationList.length; i++) {
      if (!notificationList[i].isRead) {
        notificationList[i] = NotificationModel(
          title: notificationList[i].title,
          content: notificationList[i].content,
          image: notificationList[i].image,
          id: notificationList[i].id,
          isRead: true,
          createdAt: notificationList[i].createdAt,
          updatedAt: DateTime.now(),
        );
        changed = true;
      }
    }
    if (changed) update();
  }


}
*/


import 'dart:convert';
import 'package:al_khalifa/app/api_services/utility/urls.dart';
import 'package:al_khalifa/app/modules/notification/model/notification_model.dart';
import 'package:get/get.dart';
import '../../../api_services/notifications/all_notifications.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  final box = GetStorage(); // Local storage for read notifications

  bool notificationInProgress = false;
  bool deleteNotificationInProgress = false;
  List<NotificationModel> notificationList = [];

  @override
  void onInit() {
    getAllNotification();
    super.onInit();
  }

  /// Fetch all notifications from API
  Future<bool> getAllNotification() async {
    notificationInProgress = true;
    update();

    try {
      final response = await Notifications.getNotificationRequest(Urls.notification);
      notificationInProgress = false;
      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(response.body);
        notificationList = decodedResponse.map((e) => NotificationModel.fromJson(e)).toList();

        // ✅ Restore locally read notifications
        List readIds = box.read('read_notifications') ?? [];
        for (var i = 0; i < notificationList.length; i++) {
          if (readIds.contains(notificationList[i].id)) {
            notificationList[i] = NotificationModel(
              title: notificationList[i].title,
              content: notificationList[i].content,
              image: notificationList[i].image,
              id: notificationList[i].id,
              isRead: true,
              createdAt: notificationList[i].createdAt,
              updatedAt: notificationList[i].updatedAt,
            );
          }
        }

        update();
        return true;
      } else {
        update();
        return false;
      }
    } catch (e) {
      notificationInProgress = false;
      update();
      print("error is $e");
      return false;
    }
  }

  /// Delete a notification
  Future<void> getDeleteNotification(int notificationId) async {
    deleteNotificationInProgress = true;
    update();

    try {
      final response = await Notifications.deleteNotificationRequest(
          Urls.deleteNotificationById(notificationId));
      deleteNotificationInProgress = false;
      update();

      if (response.statusCode == 204) {
        // Remove from local storage if deleted
        List readIds = box.read('read_notifications') ?? [];
        readIds.remove(notificationId);
        box.write('read_notifications', readIds);

        getAllNotification();
      } else {
        Get.snackbar('Failed', 'Problem: ${response.body}');
      }
    } catch (e) {
      deleteNotificationInProgress = false;
      update();
      Get.snackbar('Error', '$e');
    }
  }

  /// Mark a single notification as read
  void markAsRead(int id) {
    final index = notificationList.indexWhere((n) => n.id == id);
    if (index != -1 && notificationList[index].isRead == false) {
      // Create new instance with isRead = true (fields are final)
      notificationList[index] = NotificationModel(
        title: notificationList[index].title,
        content: notificationList[index].content,
        image: notificationList[index].image,
        id: notificationList[index].id,
        isRead: true,
        createdAt: notificationList[index].createdAt,
        updatedAt: DateTime.now(),
      );

      // ✅ Save locally
      List readIds = box.read('read_notifications') ?? [];
      if (!readIds.contains(id)) {
        readIds.add(id);
        box.write('read_notifications', readIds);
      }

      update();
    }
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    bool changed = false;
    List readIds = box.read('read_notifications') ?? [];

    for (int i = 0; i < notificationList.length; i++) {
      if (!notificationList[i].isRead) {
        notificationList[i] = NotificationModel(
          title: notificationList[i].title,
          content: notificationList[i].content,
          image: notificationList[i].image,
          id: notificationList[i].id,
          isRead: true,
          createdAt: notificationList[i].createdAt,
          updatedAt: DateTime.now(),
        );

        if (!readIds.contains(notificationList[i].id)) {
          readIds.add(notificationList[i].id);
        }
        changed = true;
      }
    }

    // ✅ Save all read ids locally
    box.write('read_notifications', readIds);

    if (changed) update();
  }
}
