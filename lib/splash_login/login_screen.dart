

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Routes/route_helper.dart';
import '../components/app_text_field.dart';
import '../dimensions/dimensions.dart';

class LoginScreen extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  ListView(
        children: [
          SizedBox(height: Dimensions.screenHeight*0.10,),
          Container(
            color: Colors.white,
            height: Dimensions.height10*10,
            child: Image.asset(
                'images/easyGoLogo.png'
            ),
          ),
          SizedBox(height: Dimensions.height20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome\n Login to continue", style: TextStyle(fontSize: Dimensions.font20, fontFamily: "Gilroy-Regular",)),
              SizedBox(height:Dimensions.height20-5),
              AppTextField(textController: userNameController, hintText: "username", icon: Icons.person),
              SizedBox(height: Dimensions.height20*2.5),
              AppTextField(textController: passwordController, hintText: "password", icon: Icons.password_sharp),
              SizedBox(height: Dimensions.height20*2.5),

            ],
          ),
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
                      'Login',
                      style: TextStyle(
                          fontSize: Dimensions.font20+Dimensions.font20/2,
                          color: Colors.white,
                        fontFamily: "Gilroy-Regular"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed(RouteHelper.userSignUp),
                      text: "Don't have an account already? click to sign up",
                      style: TextStyle(
                        fontFamily: "Gilroy-Regular",
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20/1.5
                      )
                  )
              )
            ],
          )


        ],
      ),
    );
  }
}
