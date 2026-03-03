import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/modules/home/views/details_menu.dart';
import 'package:al_khalifa/app/modules/home/views/product_details_screen.dart';
import 'package:al_khalifa/app/modules/home/views/see_all_meal_for_one_screen.dart';
import 'package:al_khalifa/app/modules/home/views/see_all_popular_screen.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/image_path.dart';
import '../controllers/home_controller.dart';
import '../widget/custom_header.dart';
import '../widget/food_card.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final TextEditingController _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildCustomLocationRow(),
                const SizedBox(height: 8),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildContainer(context),
                const SizedBox(height: 10),
                // Header
                CustomHeader(title: "Menu"),
                const SizedBox(height: 2),
                _buildProduct(),
                CustomHeader(
                  title: "Popular",
                  seeAllText: "See All",
                  onSeeAllTap: () {
                    Get.to(() => SeeAllPopularScreen());
                  },
                ),
                const SizedBox(height: 10),
                _buildPopularGridView(),
                const SizedBox(height: 10),
                Obx(
                  () => CustomHeader(
                    title: controller.allFoodCategory.value?.name,
                    seeAllText: "See All",
                    onSeeAllTap: () {
                      Get.to(
                        () => SeeAllMealForOneScreen(
                          title: controller.allFoodCategory.value?.name,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
              //  Text("Delivery fee included!", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                _buildMealForOneGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopularGridView() {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    int crossAxisCount = screenWidth < 500 ? 2 : 3;

    return GetBuilder<HomeController>(
      builder: (homeController) {
        if (homeController.popularDataInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final data = homeController.popularFoodItemList[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => ProductDetailsScreen(
                    imageUrl: data.food.foodImageUrl,
                    title: data.food.name,
                    rating: data.averageRating,
                    price: data.food.price,
                    description: data.food.description,
                    foodId: data.foodId,
                    variations: data.food.variations,
                  ),
                );
              },
              child: FoodCard(
                imageUrl: data.food.foodImageUrl,
                title: data.food.name,
                rating: data.averageRating,
                price: data.food.price,
                onAdd: () {},
               // cardHeight: 127,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMealForOneGridView() {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    int crossAxisCount = screenWidth < 500 ? 2 : 3;

    return GetBuilder<HomeController>(
      builder: (controller) {
       // final length = controller.allFoodCategory.value!.foods;
        if (controller.allCategoriesInProgress) {
          return Center(child: CircularProgressIndicator());
        }
       // if (controller.allFoodCategory.value?.foods == null) {
        if (controller.allFoodCategory.value == null ||
        controller.allFoodCategory.value!.foods == null ||
        controller.allFoodCategory.value!.foods.isEmpty) {
          return Column(
            children: [
              const SizedBox(height: 30,),
              Center(child: Text("Your product is empty",style: AppTextStyles.regular20,)),
              const SizedBox(height: 30,),
            ],
          );
        }
        //else {
          return GridView.builder(
            itemCount: controller.allFoodCategory.value!.foods.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final data = controller.allFoodCategory.value!.foods[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => ProductDetailsScreen(
                      imageUrl: data.foodImageUrl,
                      title: data.name,
                      rating: data.foodRatings.averageRating,
                      price: data.price,
                      description: data.description,
                      foodId: data.id,
                      variations: data.variations,
                    ),
                  );
                },
                child: FoodCard(
                  imageUrl: data.foodImageUrl,
                  title: data.name,
                  rating: data.foodRatings.averageRating,
                  price: data.price,
                  onAdd: () {},
                 // cardHeight: 135,
                ),
              );
            },
          );
       // }
      },
    );
  }

  Widget _buildProduct() {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        if (homeController.menuInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeController.allMenuModelList.length,
            itemBuilder: (context, index) {
              final menuData = homeController.allMenuModelList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 160,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => DetailsMenu(allMenuModel: menuData));
                    },
                    child: FoodCard(
                      showRating: false,
                      showAddButton: false,
                      imageUrl: menuData.menuImage,
                      title: menuData.name,
                      rating: 5.8,
                      onAdd: () {},
                      cardHeight: 140,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildContainer(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth < 400 ? 160 : 200,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share the love",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth < 400 ? 12 : 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enjoy \n30% off",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth < 400 ? 20 : 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Code : Developer",
                      style: TextStyle(
                        fontSize: screenWidth < 400 ? 14 : 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  ImagePath.footItem,
                  height: screenWidth < 400 ? 250 : 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined),
        Text("Shaistaganj", style: AppTextStyles.medium18),
        Spacer(),
        IconButton(
          onPressed: () {
            Get.toNamed(Routes.NOTIFICATION);
          },
          icon: Icon(Icons.notifications),
        ),
      ],
    );
  }
  Widget _buildSearchBar() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              backgroundColor: WidgetStateProperty.all(AppColors.greyLightColor),
              controller: _searchTEController,
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              elevation: WidgetStateProperty.all(0.0),
              leading: IconButton(
                onPressed: () async {
                  if (_searchTEController.text.isNotEmpty) {
                    Get.toNamed(
                      Routes.SEARCH_BAR,
                      arguments: {"product_list": controller.searchModel},
                    );
                    _searchTEController.clear();
                  }
                },
                icon: const Icon(
                  Icons.search,
                  size: 28,
                  color: AppColors.darkBlackColor,
                ),
              ),
              hintText: "Search for food",
              hintStyle: WidgetStateProperty.all(
                const TextStyle(
                  color: AppColors.darkBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.getSearchData(value);
                } else {
                  controller.searchModel.clear();
                  controller.update();
                }
              },

              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  await controller.getSearchData(value);
                  Get.toNamed(
                    Routes.SEARCH_BAR,
                    arguments: {"product_list": controller.searchModel},
                  );
                  _searchTEController.clear();
                }
              },
            ),
          ],
        );
      },
    );
  }

}
