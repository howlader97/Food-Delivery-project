import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:al_khalifa/app/modules/home/controllers/home_controller.dart';
import 'package:al_khalifa/app/modules/home/models/popular_food_item_model.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widget/custom_circle.dart';
import '../widget/custom_header.dart';
import '../widget/food_card.dart';

class ProductDetailsScreen extends StatelessWidget {

  final bool? sold;
  final String imageUrl;
  final String description;
  final String title;
  final double rating;
  final double price;
  final int foodId;
  final List<Variation> variations;



  ProductDetailsScreen({
    super.key,
    this.sold = false,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.price,
    required this.description,
    required this.foodId,
    required this.variations,

  });

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print(controller.selectedVariationId);
    controller.selectedVariationId(variations[0].id);
    print(controller.selectedVariationId);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(
                leadingIcon: Icons.arrow_back,
                onLeadingTap: () {
                Get.toNamed(Routes.CUSTOM_BOTTOOM_BAR,arguments: {"index":0});

                },
              ),
              FoodCard(
                showFullImage: true,
                isFullWidth: true,
                cardHeight: 150,
                imageUrl: imageUrl,
                title: title,
                rating: rating,
                price: price,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 15),
              if(variations.length>1)
                _buildTitleRow(),
                SizedBox(height: 15),
              if(variations.length>1)
                ListView.builder(
                  itemCount: variations.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = variations[index];
                    return _buildListTile(data.name, data.price.toString(), index,data.id);
                  },
                ),
              SizedBox(height: 20),
              Spacer(),
              _buildAddToCard(),
              SizedBox(height: 20.h),
              sold == true ? _buildRatingContainer() : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildRatingContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLightColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Did you like the food!', style: AppTextStyles.bold24),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: Text(
                'Please rate this food so, that we can improve it!',
                style: AppTextStyles.regular15.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                  child: Icon(
                    Icons.star_rounded,
                    size: 54.sp,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen.shade600,
                  ),
                  onPressed: () {},
                  child: Text('Rate'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCard() {
    controller.setProduct(foodId);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCircleButton(Icons.remove, controller.decrement),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Text(
                  '${controller.count.value}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            _buildCircleButton(Icons.add, controller.increment),
          ],
        ),
        CustomElevatedButton(
          onPressed: () {
            controller.getAddToCart(foodId, controller.count.value,controller.selectedVariationId.value);
          },
          text: "Add to cart",
        ),
      ],
    );
  }

  Widget _buildListTile(String title, String price,int index,int variationId) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading:  CustomCircle(
        index: index,
        variationId: variationId,
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: Text(price, style: const TextStyle(fontSize: 16)),
    );
  }






  Widget _buildCircleButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFF2F2F2),
        foregroundColor: Colors.black,
        elevation: 0,
        padding: const EdgeInsets.all(12),
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Variation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Select one", style: TextStyle(fontSize: 15)),
          ],
        ),
        CustomElevatedButton(onPressed: () {}, text: "Required"),
      ],
    );
  }
}
