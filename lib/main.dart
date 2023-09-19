import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter/services.dart';

import 'pages/welcome_page.dart';
import 'utils/colours.dart';

// void main() => runApp(const MainApp());


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
      ),
    );
  }
}