import 'package:al_khalifa/app/data/app_colors.dart';
import 'package:al_khalifa/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';
import 'custom_profile_text_field.dart';
import 'dropdown_button.dart';

class EditProfileView extends GetView<EditProfileController> {
const  EditProfileView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child:CustomProfileTextField(
                    label: 'First Name',
                    controller: controller.firstNameController,
                    hintText: 'Enter First Name',
                  ), ),
                   SizedBox(width: 8.w,),
                  Expanded(child:CustomProfileTextField(
                    label: 'Last Name',
                    controller: controller.lastNameController,
                    hintText: 'Enter Last Name',
                  ),)
                ],
              ),
              CustomProfileTextField(
                controller: controller.numberController,
                label: 'Contract Number',
                hintText: 'Example: 01xxx-xxxxxx',
              ),
              CustomProfileTextField(
                controller: controller.emailController,
                label: 'Email',
                hintText: 'company@gmail.com',
              ),
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('District', style: AppTextStyles.medium16),
                        SizedBox(height: 16.h),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.strokeColor
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(22.0.r),
                            child: Text(
                              'shaistaganj',overflow: TextOverflow.ellipsis,maxLines: 1,
                              style: AppTextStyles.regular16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('City', style: AppTextStyles.medium16),
                        SizedBox(height: 8.h),
                        Obx(() {
                          final selectedValue = controller.city.contains(controller.selectedCity.value)
                              ? controller.selectedCity.value
                              : null;

                          return AppDropdown<String>(
                            items: controller.city,
                            value: selectedValue,
                            onChanged: (v) {
                              controller.selectedCity.value = v ?? '';
                              print("Selected city: ${controller.selectedCity.value}");
                            },
                            hintText: 'Select City',
                            borderColor: AppColors.strokeColor,
                            textStyle: AppTextStyles.regular14,
                            hintStyle: AppTextStyles.regular14.copyWith(
                              color: AppColors.greyColor,
                            ),
                            padding: EdgeInsets.only(top: 8.h),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              CustomProfileTextField(
                controller: controller.addressController,
                label: 'Address',
                hintText: 'Example: House no 32,street,etc',
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<EditProfileController>(
                  builder: (editController) {
                    if(editController.editProfileInProgress){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ElevatedButton(
                      onPressed: () {
                        editController.getEditData();
                      },
                      child: Text('Save', style: AppTextStyles.medium18),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
