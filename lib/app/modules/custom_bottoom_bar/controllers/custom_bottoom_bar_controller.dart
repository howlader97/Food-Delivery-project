import 'package:al_khalifa/app/modules/order_history/views/order_history_view.dart';
import 'package:get/get.dart';
import 'package:al_khalifa/app/modules/home/views/home_view.dart';
import 'package:al_khalifa/app/modules/cart/views/cart_view.dart';
import 'package:al_khalifa/app/modules/profile/views/profile_view.dart';

class CustomBottomBarController extends GetxController {

  var currentIndex = 0.obs;


  final pages = [
     HomeView(),
    const CartView(),
      OrderHistoryView(),
    const ProfileView(),
  ];


  void changeTab(int index) {
    currentIndex.value = index;
  }


}
