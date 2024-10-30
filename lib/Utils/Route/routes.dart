import 'package:flutter/material.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/view/Home_View.dart';
import 'package:mblog/view/Signup_View.dart';
import 'package:mblog/view/Splash_View.dart';
import 'package:mblog/view/forgot_password.dart';
import 'package:mblog/view/login_View.dart';

class Routes{
  static Route<dynamic> onGenerateRoute(RouteSettings set){
    switch(set.name){
      case RouteName.splash:
        return MaterialPageRoute(builder: (_)=>SplashView());
      case RouteName.login:
        return MaterialPageRoute(builder: (_)=>LoginView());
      case RouteName.signUP:
        return MaterialPageRoute(builder: (_)=>SignupView());
      case RouteName.home:
        return MaterialPageRoute(builder: (_)=>HomeView());
      case RouteName.forgot:
        return MaterialPageRoute(builder: (_)=>ForgotPassword());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('404 page Error !!!'),
            ),
          );
        });
    }
  }
}