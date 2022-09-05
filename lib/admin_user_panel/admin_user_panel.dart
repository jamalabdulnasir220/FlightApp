//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:theo/Routes/route_helper.dart';
//
// import '../dimensions/dimensions.dart';
//
// class AdminUserPanel extends StatelessWidget {
//   const AdminUserPanel({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body:  ListView(
//         children: [
//           SizedBox(height: Dimensions.screenHeight*0.10,),
//           Container(
//             color: Colors.white,
//             height: Dimensions.height10*10,
//             child: Image.asset(
//                 'images/easyGoLogo.png'
//             ),
//           ),
//           SizedBox(height: Dimensions.height20*2.5),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Get.toNamed(RouteHelper.loginAdmin);
//                 },
//                 child: Container(
//                 //  margin: EdgeInsets.only(left: Dimensions.height20*4, right: Dimensions.height20*4),
//                   width: Dimensions.screenWidth/3,
//                   height: Dimensions.screenHeight/13,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radius30),
//                     color: Colors.lightBlue,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Login as admin',
//                       style: TextStyle(
//                           fontSize: Dimensions.font20+Dimensions.font20/2,
//                           color: Colors.white
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: Dimensions.height10*10),
//
//               GestureDetector(
//                 onTap: () {
//                   Get.toNamed(RouteHelper.loginUser);
//                 },
//                 child: Container(
//                   //  margin: EdgeInsets.only(left: Dimensions.height20*4, right: Dimensions.height20*4),
//                   width: Dimensions.screenWidth/3,
//                   height: Dimensions.screenHeight/13,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radius30),
//                     color: Colors.lightBlue,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Login as user',
//                       style: TextStyle(
//                           fontSize: Dimensions.font20+Dimensions.font20/2,
//                           color: Colors.white
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           )
//
//
//         ],
//       ),
//     );
//   }
// }
