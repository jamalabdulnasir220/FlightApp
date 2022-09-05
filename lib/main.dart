import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:theo/admin_user_panel/admin_user_panel.dart';
import 'package:theo/dashboard.dart';
import 'package:theo/splash_login/splash_screen.dart';
import 'Routes/route_helper.dart';
import 'admin/admin_sign_up.dart';
import 'components/color.dart';
import 'controllers/flight_controller.dart';

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
    return GetMaterialApp(
      theme: ThemeData(
        buttonColor: Colours.magenta,
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Gilroy-Regular'),
        ),
        appBarTheme: AppBarTheme(
            color: Colours.darkBlue
        ),
        fontFamily: "Gilroy-Regular",
      ),
      home: SplashScreen(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
      // home: AdminUserPanel(),
    );
  }
}



