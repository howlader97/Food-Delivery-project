import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/modules/home/controllers/home_controller.dart';
import 'package:al_khalifa/app/modules/home/widget/custome_location_row.dart';
import 'package:al_khalifa/app/modules/home/widget/food_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/product_details_screen.dart';
import '../controllers/search_bar_controller.dart';

class SearchBarView extends GetView<SearchBarController> {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = controller.searchTEController;

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (homeController) {
            final searchList = homeController.searchModel;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomLocationRow(),
                  const SizedBox(height: 8),
                  _buildSearchBar(homeController, searchController),
                  const SizedBox(height: 20),

                  /// No data section
                  if (!homeController.searchInProgress &&
                      searchList.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Text(
                          "No Data Available",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                  /// Data grid section
                  if (!homeController.searchInProgress &&
                      searchList.isNotEmpty)
                    GridView.builder(
                      itemCount: searchList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final data = searchList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                  () => ProductDetailsScreen(
                                imageUrl: data.foodImageUrl,
                                title: data.name,
                                rating: data.foodRatings.averageRating,
                                price: data.price.toDouble(),
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
                            price: data.price.toDouble(),
                            onAdd: () {},
                           // cardHeight: 127,
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
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

  Widget _buildSearchBar(HomeController homeController, TextEditingController searchTEController) {
    return SearchBar(
      backgroundColor: WidgetStateProperty.all(AppColors.greyLightColor),
      controller: searchTEController,
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevation: WidgetStateProperty.all(0.0),
      leading: IconButton(
        onPressed: () {
          if (searchTEController.text.isNotEmpty) {
            homeController.getSearchData(searchTEController.text);
            searchTEController.clear();
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
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          homeController.getSearchData(value);
          searchTEController.clear();
        }
      },
    );
  }
}
