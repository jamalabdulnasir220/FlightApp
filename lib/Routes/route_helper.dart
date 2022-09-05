import 'package:get/get.dart';
import 'package:theo/splash_login/sign_up.dart';

import '../admin/admin_sign_up.dart';
import '../admin_user_panel/admin_user_panel.dart';
import '../dashboard.dart';
import '../main/home.dart';
import '../splash_login/login_screen.dart';
import '../splash_login/splash_screen.dart';


class RouteHelper {

  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String adminUserPanel = "/admin-user-panel";
  static const String loginUser = "/login-user";
  static const String userSignUp = "/user-sign-up";
  // static const String adminSignUp = "/admin-sign-up";
  static const String home = "/home";
  static const String dashBoard = "/dashboard";

  static String getSplashPage()=>"$splashPage";
  static String getInitial()=>"$initial";
  // static String getAdminUserPanel()=>"$adminUserPanel";
  static String getLoginUser()=>"$loginUser";
  // static String getLoginAdmin()=>"$loginAdmin";
  static String getUserSignUp()=>"$userSignUp";
  // static String getAdminSignUp()=>"$adminSignUp";
  static String getHome()=> "$home";
  static String getDashBoard()=>"$dashBoard";



  static List<GetPage> routes = [
    GetPage(name: dashBoard, page: ()=>Dashboard()),
    GetPage(name: splashPage, page:()=>SplashScreen()),
    GetPage(name: home, page: ()=>Home()),
    GetPage(name: loginUser, page: ()=>LoginScreen()),
    GetPage(name: userSignUp, page: ()=>SignUpScreen()),

    //
    // GetPage(name: cartPage, page: (){
    //   return CartPage();
    // },
    //     transition: Transition.fadeIn
    //)
  ];



}