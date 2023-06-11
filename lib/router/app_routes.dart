import 'package:get/get.dart';
import 'package:tweetapp/view/tweet_screen.dart';

import '../view/auth_screen.dart';
import '../view/home_screen.dart';

class Routes {
  static String authScreen = '/authScreen';
  static String homeScreen = '/homeScreen';
  static String tweetScreen = '/tweetScreen';
}

final getPages = [
  GetPage(
    name: Routes.authScreen,
    page: () => const AuthScreen(),
  ),
  GetPage(
    name: Routes.homeScreen,
    page: () => HomeScreen(googleAccount: Get.arguments),
  ),
  GetPage(
    name: Routes.tweetScreen,
    page: () => TweetScreen(tweetItem: Get.arguments.first),
  ),
];
