import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theo/data/api/backend_api.dart';
import '../Routes/route_helper.dart';
import '../components/app_text_field.dart';
import '../dimensions/dimensions.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController userNameController = TextEditingController();
  String email = "";

  String password = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: Dimensions.screenHeight * 0.10,
          ),
          Container(
            color: Colors.white,
            height: Dimensions.height10 * 10,
            child: Image.asset('images/easyGoLogo.png'),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome\n Login to continue",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontFamily: "Gilroy-Regular",
                  )),
              SizedBox(height: Dimensions.height20 - 5),
              AppTextField(
                  onChanged: (val) {
                    email = val;
                  },
                  // textController: userNameController,
                  hintText: "email",
                  icon: Icons.email_rounded),
              SizedBox(height: Dimensions.height20 * 2.5),
              AppTextField(
                  // textController: passwordController,
                  onChanged: (val) {
                    password = val;
                  },
                  hintText: "password",
                  icon: Icons.password_sharp),
              SizedBox(height: Dimensions.height20 * 2.5),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  isLoading = true;
                  setState(() {});
                  bool success =
                      await BackendApi.login(email: email, password: password);
                  if (success) {
                    await BackendApi.getUserProfile();
                    Get.toNamed(RouteHelper.dashBoard);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("wrong username or password")));
                  }
                  isLoading = false;
                  setState(() {});
                  // Get.toNamed(RouteHelper.dashBoard);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.height20 * 4,
                      right: Dimensions.height20 * 4),
                  width: Dimensions.screenWidth / 5,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.lightBlue,
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Login',
                            style: TextStyle(
                                fontSize:
                                    Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                                fontFamily: "Gilroy-Regular"),
                          ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(RouteHelper.userSignUp),
                  text: "Don't have an account already? click to sign up",
                  style: TextStyle(
                      fontFamily: "Gilroy-Regular",
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20 / 1.5),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
