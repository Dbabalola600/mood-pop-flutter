import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'pages/DashBoard/dash_board_page.dart';
import 'pages/welcome_page.dart';
import 'utils/colours.dart';

// void main() => runApp(const MainApp());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

//splash screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: blackColor,
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage(
            "assets/images/MoodLogo.svg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
          child: SvgPicture.asset(
        "assets/logos/MoodLogo.svg",
        alignment: Alignment.center,
        width: 100,
        height: 100,
      )),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late bool isAppReady = false;

  @override
  void initState() {
    super.initState();
    initializeApp().then((_) {
      setState(() {
        isAppReady = true;
      });
    });
  }

  Future<void> initializeApp() async {
    // Perform any necessary initialization tasks here
    // For example, you can load data or set up services
    await Future.delayed(
        const Duration(seconds: 4)); // Simulate a 2-second initialization
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return isAppReady ? buildApp() : const SplashScreen();
  }

  Widget buildApp() {
    return FutureBuilder<GetMaterialApp>(
      future: checker(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data ??
              Container(); // Return a default widget if data is null
        } else {
          return const CircularProgressIndicator(); // Show a loading indicator while checking
        }
      },
    );
  }

  Future<GetMaterialApp> checker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("userId") == null) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
        ),
      );
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const DashBoardPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
        ),
      );
    }
  }
}








// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     Future<GetMaterialApp> checker() async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       if (prefs.getString("userId") == "") {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: const HomePage(),
//           theme: ThemeData(
//             scaffoldBackgroundColor: whiteColor,
//           ),
//         );
//       } else {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: const DashBoardPage(),
//           theme: ThemeData(
//             scaffoldBackgroundColor: whiteColor,
//           ),
//         );
//       }
//     }

//     // return GetMaterialApp(
//     //   debugShowCheckedModeBanner: false,
//     //   home: const HomePage(),
//     //   theme: ThemeData(
//     //     scaffoldBackgroundColor: whiteColor,
//     //   ),
//     // );
//   }
// }
