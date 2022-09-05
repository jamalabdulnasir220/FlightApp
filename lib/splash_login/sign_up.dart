import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:theo/Routes/route_helper.dart';
import 'package:theo/dashboard.dart';
import 'package:theo/otherScreens/payment_method.dart';

import '../components/app_text_field.dart';
import '../dimensions/dimensions.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameOfCompany = TextEditingController();
    var ownerName = TextEditingController();
    var userName = TextEditingController();
    var password = TextEditingController();
    var confirmPassword = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,

      body: ListView(
        children: [
          SizedBox(height: Dimensions.screenHeight*0.05,),
          Container(
            height: Dimensions.height10*10,
            child: Image.asset('images/easyGoLogo.png'),
          ),
          SizedBox(height: Dimensions.height10,),
          AppTextField(textController: nameOfCompany, hintText: "Firstname", icon: Icons.person),
          SizedBox(height: Dimensions.height20),
          AppTextField(textController: ownerName, hintText: "Lastname", icon: Icons.person),
          SizedBox(height: Dimensions.height20),
          AppTextField(textController: userName, hintText: "username", icon: Icons.person),
          SizedBox(height: Dimensions.height20),
          AppTextField(textController: password, hintText: "password", icon: Icons.password_sharp),
          SizedBox(height: Dimensions.height20),
          AppTextField(textController: confirmPassword, hintText: "confirm password", icon: Icons.password_sharp),
          SizedBox(height: Dimensions.height20),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.dashBoard);
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.height20*4, right: Dimensions.height20*4),
                  width: Dimensions.screenWidth/5,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.lightBlue,
                  ),
                  child: Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: Dimensions.font20+Dimensions.font20/2,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.loginUser);
                },
                child: RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: "Have an icon account already?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    )
                ),
              )
            ],
          )


        ],
      ),
    );
  }
}
