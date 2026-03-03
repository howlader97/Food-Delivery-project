import 'dart:convert';
import 'dart:io';

import 'package:al_khalifa/app/api_services/profile_api_services/profile_api_services.dart';
import 'package:al_khalifa/app/api_services/utility/urls.dart';
import 'package:al_khalifa/app/modules/history_page/bindings/history_page_binding.dart';
import 'package:al_khalifa/app/modules/history_page/controllers/history_page_controller.dart';
import 'package:al_khalifa/app/modules/profile/model/profile_model.dart';
import 'package:al_khalifa/app/shared_prerf_services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController {

  bool profileInProgress=false;
  var profileModelInfo = ProfileModel(
    id: 0,
    firstName: '',
    lastName: '',
    email: '',
    city: '',
    district: '',
    address: '',
    phoneNumber: '',
    role: '',
  ).obs;

  XFile ? _pickedImage;

  XFile? get pickedImage => _pickedImage;
  // ---- SAVE IMAGE TO SHARED PREF ----
  Future<void> _saveImageToPrefs(String path) async {
    final prefs = await SharedPrefServices.getInstance();
   // await prefs.setString('profile_image_path', path);
    await prefs.put('profile_image_path', path);
  }

  // ---- LOAD IMAGE FROM SHARED PREF ----
  Future<void> _loadImageFromPrefs() async {
    final prefs = await SharedPrefServices.getInstance();
    //final savedPath = prefs.getString('profile_image_path');
    final savedPath = prefs.get('profile_image_path');
    if (savedPath != null && File(savedPath).existsSync()) {
      _pickedImage = XFile(savedPath);
    }
  }

  Future<void> setPickedImage(XFile image) async {
    _pickedImage = image;
    await _saveImageToPrefs(image.path);
    update();
  }


  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      _pickedImage = XFile(pickedFile.path);
      await _saveImageToPrefs(pickedFile.path);
      update();
    }
  }


  void chooseImageFrom() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () {
                  pickImage(
                      ImageSource.gallery
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Future<bool> getProfileData()async{
    profileInProgress=true;
    update();
    try{
      final response=await ProfileApiServices.getProfileDataRequest(Urls.getProfile);
      profileInProgress=false;

      if(response.statusCode == 200){
        final decodedResponse=jsonDecode(response.body);
        profileModelInfo.value=ProfileModel.fromJson(decodedResponse);

        update();
        return true;
      }else{
        update();
        return false;
      }
    }catch(e){
      profileInProgress=false;
      update();
      return false;
    }
  }

 @override
  void onInit() {
    super.onInit();
    getProfileData();
    _loadImageFromPrefs();
  }
}
