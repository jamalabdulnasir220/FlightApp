import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:theo/Routes/route_helper.dart';
import 'package:theo/dashboard.dart';
import 'package:theo/data/api/backend_api.dart';
import 'package:theo/otherScreens/payment_method.dart';
import 'package:theo/splash_login/login_screen.dart';

import '../components/app_text_field.dart';
import '../dimensions/dimensions.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String firstName = "";
    String lastName = "";
    String email = "";
    String password = "";
    String confirmPassword = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: Dimensions.screenHeight * 0.05,
          ),
          Container(
            height: Dimensions.height10 * 10,
            child: Image.asset('images/easyGoLogo.png'),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          AppTextField(
              onChanged: (val) {
                firstName = val;
              },
              hintText: "Firstname",
              icon: Icons.person),
          SizedBox(height: Dimensions.height20),
          AppTextField(
              onChanged: (val) {
                lastName = val;
              },
              hintText: "Lastname",
              icon: Icons.person),
          SizedBox(height: Dimensions.height20),
          AppTextField(
              onChanged: (val) {
                email = val;
              },
              hintText: "email",
              icon: Icons.person),
          SizedBox(height: Dimensions.height20),
          AppTextField(
              onChanged: (val) {
                password = val;
              },
              hintText: "password",
              icon: Icons.password_sharp),
          SizedBox(height: Dimensions.height20),
          AppTextField(
              onChanged: (val) {
                confirmPassword = val;
              },
              hintText: "confirm password",
              icon: Icons.password_sharp),
          SizedBox(height: Dimensions.height20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (firstName.isEmpty ||
                      lastName.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("please enter required data")));
                  } else if (password != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password doesn't match"),
                      ),
                    );
                  } else {
                    isLoading = true;
                    setState(() {});
                    try {
                      await BackendApi.signUp(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        password: password,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                    // Get.toNamed(RouteHelper.dashBoard);
                    isLoading = false;
                    setState(() {});
                  }
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
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize:
                                    Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white),
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an icon account already?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20))),
              )
            ],
          )
        ],
      ),
    );
  }
}
