import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'router/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const TweetApp());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class TweetApp extends StatelessWidget {
  const TweetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.authScreen,
      getPages: getPages,
    );
  }
}
