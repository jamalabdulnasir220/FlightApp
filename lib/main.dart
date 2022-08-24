import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:theo/dashboard.dart';
import 'package:theo/otherScreens/seats_page.dart';
import 'package:theo/splash_login/splash_screen.dart';

import 'components/color.dart';
import 'components/flight_model.dart';
import 'controllers/popular_flight_controllers.dart';
import 'controllers/popular_flight_controllers.dart';
import 'helper/dependencies.dart' as dep;
//
// Future<void> main() async {
//    WidgetsFlutterBinding.ensureInitialized();
//    await dep.init();
//   runApp(MaterialApp(
//     theme: ThemeData(
//       buttonColor: Colours.magenta,
//       textTheme: const TextTheme(
//         subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Gilroy-Regular'),
//       ),
//       appBarTheme: AppBarTheme(
//           color: Colours.darkBlue
//       ),
//       fontFamily: "Calibri",
//     ),
//     home: SplashScreen(),
//   ));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularFlightController>().getPopularFlightList();
    return GetMaterialApp(
      theme: ThemeData(
        buttonColor: Colours.magenta,
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Gilroy-Regular'),
        ),
        appBarTheme: AppBarTheme(
            color: Colours.darkBlue
        ),
        fontFamily: "Calibri",
      ),
      home: SplashScreen(),
    );
  }
}



