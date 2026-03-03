// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefServices{
//
//   static String userOtp='';
//
//   static Future<void> saveUserEmail(String email)async{
//     final SharedPreferences prefs=await SharedPreferences.getInstance();
//     await prefs.setString("user_email", email);
//     await getUserEmail();
//   }
//
//   static Future<String?> getUserEmail()async{
//     final SharedPreferences prefs=await SharedPreferences.getInstance();
//     final memory=prefs.getString("user_email");
//     return memory;
//   }
//
//   static Future<void> saveUserOtp(String otp)async{
//     final SharedPreferences prefs=await SharedPreferences.getInstance();
//     await prefs.setString("user_otp", otp);
//     final saveOtp=await getUserOtp();
//     userOtp=otp;
//     print("saveOtp \\\\ $saveOtp");
//   }
//
//   static Future<String?> getUserOtp()async{
//     final SharedPreferences prefs=await SharedPreferences.getInstance();
//     final checkOtp=prefs.getString("user_otp");
//     return checkOtp;
//   }
//
//   static Future<void> saveUserToken(String token)async{
//     final SharedPreferences prefs=await SharedPreferences.getInstance();
//     await prefs.setString("user_token", token);
//   }
//
//   static Future<String?> getUserToken()async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("user_token");
//   }
//
//   static Future<void> clear()async{
//     final SharedPreferences prefs=await SharedPreferences.getInstance();
//     final savedImagePath = prefs.getString('profile_image_path');
//     await prefs.clear();
//     if (savedImagePath != null) {
//       await prefs.setString('profile_image_path', savedImagePath);
//     }
//   }
//
//   static Future<bool> get isLoggedIn async {
//     String? userToken= await getUserToken();
//     return userToken != null;
//   }
//   static Future<SharedPreferences> getInstance() async {
//     return await SharedPreferences.getInstance();
//   }
//
//
// }
//
//

import 'package:hive_flutter/hive_flutter.dart';


class SharedPrefServices {
  static String userOtp = '';

  static Future<void> saveUserEmail(String email) async {
    final box = await Hive.openBox('app_data');
    await box.put("user_email", email);
    await getUserEmail();
  }

  static Future<String?> getUserEmail() async {
    final box = await Hive.openBox('app_data');
    return box.get("user_email");
  }

  static Future<void> saveUserOtp(String otp) async {
    final box = await Hive.openBox('app_data');
    await box.put("user_otp", otp);
    final saveOtp = await getUserOtp();
    userOtp = otp;
    print("saveOtp \\ $saveOtp");
  }

  static Future<String?> getUserOtp() async {
    final box = await Hive.openBox('app_data');
    return box.get("user_otp");
  }

  static Future<void> saveUserToken(String token) async {
    final box = await Hive.openBox('app_data');
    await box.put("user_token", token);
  }

  static Future<String?> getUserToken() async {
    final box = await Hive.openBox('app_data');
    return box.get("user_token");
  }

  static Future<void> clear() async {
    final box = await Hive.openBox('app_data');
    final savedImagePath = box.get('profile_image_path');
    await box.clear();
    if (savedImagePath != null) {
      await box.put('profile_image_path', savedImagePath);
    }
  }

  static Future<bool> get isLoggedIn async {
    String? userToken = await getUserToken();
    return userToken != null;
  }

  static Future<Box> getInstance() async {
    return await Hive.openBox('app_data');
  }

  static Future<void> saveIsCancelButtonTappedStatus(bool status)async{
    final box=await Hive.openBox("app_data");
    await box.put("isCancelButtonTapped", status);
  }


  static Future<bool> getIsCancelButtonTappedStatus()async{
    final box=await Hive.openBox("app_data");
    return box.get("isCancelButtonTapped",defaultValue: false);
  }
}
