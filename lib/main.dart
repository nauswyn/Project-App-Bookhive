import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../views/mainpage/homepage.dart';

import '../../viewsmodel/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
  

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeController.themeMode.value,
      home: HomePage(),
    );
  }
}








  // await Firebase.initializeApp();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);