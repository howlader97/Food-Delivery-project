import 'package:al_khalifa/app/modules/home/controllers/home_controller.dart';
import 'package:al_khalifa/app/modules/home/views/product_details_screen.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/custom_header.dart';
import '../widget/food_card.dart';

class SeeAllMealForOneScreen extends StatelessWidget {
  final String? title;
  const SeeAllMealForOneScreen({super.key,  this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                CustomHeader(
                  title:title ,
                  centerTitle: true,
                  leadingIcon: Icons.arrow_back,
                  onLeadingTap: (){
                    Get.toNamed(Routes.CUSTOM_BOTTOOM_BAR,arguments: {"index":0});
                  },
                ),
                _buildPopularGridView()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPopularGridView() {
    final screenWidth = Get.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    return GetBuilder<HomeController>(
      builder: (controller) {
        if(controller.allCategoriesInProgress){
          return Center(child: CircularProgressIndicator(),);
        }
        if(controller.allFoodCategory.value == null){
          return Center(child: Text('no data'),);
        }else{
          return GridView.builder(
            itemCount: controller.allFoodCategory.value?.foods.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final data =controller.allFoodCategory.value!.foods[index];
              return GestureDetector(
                onTap: () {
                  Get.to(()=>ProductDetailsScreen(
                      imageUrl: data.foodImageUrl,
                      title: data.name,
                      rating: data.foodRatings.averageRating,
                      price: data.price,
                      description: data.description,
                      foodId: data.id,
                      variations: data.variations,
                  )
                  );
                },
                child: FoodCard(
                  imageUrl: data.foodImageUrl,
                  title: data.name,
                  rating: data.foodRatings.averageRating,
                  price: data.price,
                  onAdd: () {},
                  cardHeight: 135,
                ),
              );
            },
          );
        }
      }
    );
  }
}
