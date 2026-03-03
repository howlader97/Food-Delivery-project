import 'dart:async';
import 'dart:convert';
import 'package:al_khalifa/app/api_services/add_to_cart_services/add_to_cart_services.dart';
import 'package:al_khalifa/app/api_services/food_categories_api_services/food_categories_api_services.dart';
import 'package:al_khalifa/app/api_services/menu_api_services/menu_api_services.dart';
import 'package:al_khalifa/app/api_services/search_api_services/search_api_services.dart';
import 'package:al_khalifa/app/api_services/utility/urls.dart';
import 'package:al_khalifa/app/modules/cart/controllers/cart_controller.dart';
import 'package:al_khalifa/app/modules/home/models/all_food_categories_model.dart';
import 'package:al_khalifa/app/modules/home/models/all_menu_model.dart';
import 'package:al_khalifa/app/modules/home/models/popular_food_item_model.dart';
import 'package:al_khalifa/app/modules/home/models/search_model.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/widgets/showCustomSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_services/popular_food_api_services/popular_food_api_services.dart';

class HomeController extends GetxController {
  @override

  void onInit() {

    getAllMenu();
    getPopularData();
    getAllCategories(23);
    super.onInit();
  }

  bool menuInProgress = false;
  bool popularDataInProgress = false;
  bool addToCartInProgress = false;
  bool allCategoriesInProgress=false;
  bool searchInProgress=false;
  var selectedIndex = (-1).obs;
  var selectedVariationId = (-1).obs;

  void selectIndex(int index,variationID) {
    selectedIndex.value = index;
    selectedVariationId.value=variationID;
    print(selectedVariationId.value);
  }

  void selectedVariationID(int vid){
    selectedVariationId.value=vid;
    print(selectedVariationId.value);
  }

  List<AllMenuModel> allMenuModelList = [];
  List<PopularFoodItemModel> popularFoodItemList = [];
  Rxn<AllFoodCategoriesModel> allFoodCategory = Rxn<AllFoodCategoriesModel>();
  
  Future<bool> getAllCategories(int foodId)async{
    allCategoriesInProgress=true;
    update();
    try{
      final response = await FoodCategoriesApiServices.foodCategoriesApiRequest(Urls.foodCategories(foodId));
      allCategoriesInProgress=false;
      if(response.statusCode == 200){
        final deCodedResponse=jsonDecode(response.body);
        allFoodCategory.value =
            AllFoodCategoriesModel.fromJson(deCodedResponse);
        update();
        return true;

      }else{
        update();
        return false;
      }

    }catch(e){
      allCategoriesInProgress=false;
      update();
      throw 'Error is $e';
    }
  }

  Future<bool> getAllMenu() async {
    menuInProgress = true;
    update();
    try {
      final response = await MenuApiServices.getAllMenuRequest(Urls.allMenu);
      menuInProgress = false;
      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(response.body);
        allMenuModelList = decodedResponse
            .map((e) => AllMenuModel.fromJson(e))
            .toList();
        update();
        return true;
      } else {
        update();
        return false;
      }
    } catch (e) {
      menuInProgress = false;
      update();
      print("error is $e");
      return false;
    }
  }

  Future<bool> getPopularData() async {
    popularDataInProgress = true;
    update();
    try {
      final response = await PopularFoodApiServices.getPopularItemRequest(
        Urls.popularFoodData,
      );
      popularDataInProgress = false;
      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(response.body);
        popularFoodItemList = decodedResponse
            .map((e) => PopularFoodItemModel.fromJson(e))
            .toList();
        update();
        return true;
      } else {
        update();
        return false;
      }
    } catch (e) {
      menuInProgress = false;
      update();
      print("error is $e");
      return false;
    }
  }

  Future<void> getAddToCart(int productId, int quantity,int variationId) async {
    addToCartInProgress = true;
    update();
    try {
      final response = await AddToCartServices.addToCartServices(
        Urls.addCart,
        <String, dynamic>{"product_id": productId, "quantity": quantity,"variation_id":variationId},
      );
      addToCartInProgress = false;
      update();
      print(response.statusCode);
      print('${response.body}');
      if (response.statusCode == 201) {
        showCustomSnackbar(context: Get.context!, title: 'success', message: "Data Add To Cart successful",backgroundColor: Colors.green);
         final cart = Get.find<CartController>();
         await cart.getCartListData();
         count.value =1;
         Get.toNamed(Routes.CUSTOM_BOTTOOM_BAR,arguments: {"index":1});
      } else {
        showCustomSnackbar(context: Get.context!, title: 'Failed', message: '${response.body}', backgroundColor: Colors.red.shade400,);
        print(response.body);
      }
    } catch (e) {
      addToCartInProgress = false;
      update();
      Get.snackbar('Error', 'Something went wrong: ${e.toString()}');
    }
  }

  final Map<int, RxInt> _counts = {};

  int? _currentProductId;

  void setProduct(int productId) {
    _currentProductId = productId;
    _counts[productId] = 1.obs;
  }

  RxInt get count {
    final id = _currentProductId;
    if (id == null) return 1.obs; // safety
    return _counts[id]!;
  }

  void increment() {
    final id = _currentProductId;
    if (id == null) return;
    _counts[id]!.value++;
  }

  void decrement() {
    final id = _currentProductId;
    if (id == null) return;
    if (_counts[id]!.value > 1) {
      _counts[id]!.value--;
    }
  }

  List<SearchModel> _searchModel = [];
  List<SearchModel> get searchModel => _searchModel;

  Future<bool> getSearchData(String query)async{
    searchInProgress=true;
    update();
    try{
      final response=await SearchApiServices.searchApiRequest("${Urls.search}$query");
      searchInProgress=false;
      if(response.statusCode == 200){
        List<dynamic> deCodedResponse=jsonDecode(response.body);
        _searchModel = deCodedResponse
            .map((e) => SearchModel.fromJson(e))
            .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        update();
        return true;
      }else{
        update();
        return false;
      }

    }catch(e){
      searchInProgress=false;
      update();
      Get.snackbar('failed', '$e');
      return false;

    }
  }


}


