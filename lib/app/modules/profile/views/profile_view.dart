import 'dart:io';
import 'package:al_khalifa/app/routes/app_pages.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
   const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        title: Text('Profile', style: AppTextStyles.regular18),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){
                Get.toNamed(Routes.CURENT_LOCATION);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<ProfileController>(
                builder: (profileController) {
                  if(profileController.profileInProgress){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Column(
                    children: [
                    Stack(
                    alignment: Alignment.center,
                    children: [

                      CircleAvatar(
                        radius: 70.r,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: profileController.pickedImage != null
                            ? FileImage(File(profileController.pickedImage!.path))
                            : null,
                      ),
                     // if (profileController.pickedImage == null)
                        Positioned(
                          bottom: 10, // move upward if needed
                          right: 10,  // right side of the avatar
                          child: InkWell(
                            onTap: () => profileController.chooseImageFrom(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 25.h),
                        child:Text("${profileController.profileModelInfo.value.firstName} ${profileController.profileModelInfo.value.lastName}",
                          style: AppTextStyles.medium20,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(profileController.profileModelInfo.value.phoneNumber, style: AppTextStyles.regular14),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: Text(
                         profileController.profileModelInfo.value.email,
                          style: AppTextStyles.regular14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                   /*   ListTile(
                        leading: const Icon(Icons.card_giftcard),
                        title: Text('Invite Friend', style: AppTextStyles.regular14),
                        trailing: const Icon(Icons.arrow_forward_ios_sharp),
                        onTap: () {},
                      ),*/
                      ListTile(
                        leading: const Icon(Icons.card_giftcard),
                        title: Text('History', style: AppTextStyles.regular14),
                        trailing: const Icon(Icons.arrow_forward_ios_sharp),
                        onTap: () {
                          Get.toNamed(Routes.HISTORY_PAGE);
                        },
                      ),
                    ],
                  );
                }
              ),
              SizedBox(height: 80.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async{
                    await SharedPrefServices.clear();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.2.w, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    fixedSize: Size.fromHeight(47.h),
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Log Out',style: AppTextStyles.medium18,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
