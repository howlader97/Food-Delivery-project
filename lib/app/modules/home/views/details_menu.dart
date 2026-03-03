import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/modules/home/models/all_menu_model.dart';
import 'package:al_khalifa/app/modules/home/widget/custom_header.dart';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class DetailsMenu extends StatelessWidget {
  final AllMenuModel allMenuModel;

  const DetailsMenu({super.key, required this.allMenuModel});

  @override
  Widget build(BuildContext context) {

    print("${allMenuModel.menuItemList}");
    print("${allMenuModel.id}");
    print("${allMenuModel.menuImage}");
    print("${allMenuModel.name}");

    return Scaffold(
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(
                title: "Menu Details",
                centerTitle: true,
                leadingIcon: Icons.arrow_back,
                onLeadingTap: (){
                  Get.toNamed(Routes.CUSTOM_BOTTOOM_BAR,arguments: {"index":0});
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ClipRect(
                  child: Image.network(
                    allMenuModel.menuImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(allMenuModel.name,style: TextStyle(fontSize: 18,color: AppColors.darkBlackColor,fontWeight: FontWeight.w500),),
              const SizedBox(height: 8),
              Text('Menu Item',style: TextStyle(fontSize: 18,color: AppColors.darkBlackColor,fontWeight: FontWeight.w500),),
              const SizedBox(height: 8),


            Html(
              data: allMenuModel.menuItemList,
              style: {
                "*": Style(
                  textAlign: TextAlign.left,
                  color:AppColors.darkBlackColor,
                  width: Width(300, Unit.px),
                  fontWeight: FontWeight.w500,
                ),
              },
            ),
              const SizedBox(height: 8),
              Text('price: ${allMenuModel.price}tk',style: TextStyle(fontSize: 16,color: AppColors.darkBlackColor,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}
