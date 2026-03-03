class Urls {
  static const String _baseUrl = 'https://khalifa.mtscorporate.com';
  static String registration = '$_baseUrl/user/registration';
  static String otpSignUp = '$_baseUrl/user/user_otp_verify';
  static String signIn = '$_baseUrl/user/login';
  static String googleSignIn = '$_baseUrl/auth/google/token';
  static String emailVerify = '$_baseUrl/user/resend-otp';
  static String resetPassword = '$_baseUrl/user/reset_password';
  static String allMenu = '$_baseUrl/menus/';
  static String popularFoodData = '$_baseUrl/food_rating/filter/popular';
  static String notification = '$_baseUrl/notifications/';
  static String getProfile = '$_baseUrl/profile/me';
  static String editProfile = '$_baseUrl/profile/update}';
  static String addCart = '$_baseUrl/carts/';
  static String cartList = '$_baseUrl/carts/me';

  static String deleteCart(int id) => '$_baseUrl/carts/$id';

  static String decreaseItem(int id) => '$_baseUrl/carts/$id/decrease';

  static String foodCategories(int id) => '$_baseUrl/food-categories/$id';

  static String deleteNotificationById(int id) => '$_baseUrl/notifications/$id';
  static String order = '$_baseUrl/orders/';
  static String myOrder = '$_baseUrl/orders/user/me';

  static String orderDelete(int orderId) => '$_baseUrl/orders/$orderId';
  static String paymentHistory = '$_baseUrl/payment_history/user/me';

  static String paymentDetailsHistory(int id) =>
      '$_baseUrl/payment_history/user_payment/$id';
  static String search = '$_baseUrl/search/?q=';

  static String foodRatings = '$_baseUrl/food_rating/';
}
