import 'package:flutter/material.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/view/navigator_screen/Home_View.dart';
import 'package:mblog/view/Signup_View.dart';
import 'package:mblog/view/Splash_View.dart';
import 'package:mblog/view/navigator_screen/add_blog.dart';
import 'package:mblog/view/choice_view.dart';
import 'package:mblog/view/forgot_password.dart';
import 'package:mblog/view/login_View.dart';
import 'package:mblog/view/navigator_screen/bottom_bar.dart';
import 'package:mblog/view/navigator_screen/explore.dart';
import 'package:mblog/view/navigator_screen/favourite.dart';
import 'package:mblog/view/navigator_screen/users_details.dart';
import 'package:mblog/view/postDetailsScreen.dart';

class Routes{
  static Route<dynamic> onGenerateRoute(RouteSettings set){
    switch(set.name){
      case RouteName.splash:
        return MaterialPageRoute(builder: (_)=>SplashView());
      case RouteName.medScreen:
        return MaterialPageRoute(builder: (_)=>ChoiceView());
      case RouteName.login:
        return MaterialPageRoute(builder: (_)=>LoginView());
      case RouteName.signUP:
        return MaterialPageRoute(builder: (_)=>SignupView());
      case RouteName.home:
        return MaterialPageRoute(builder: (_)=>HomeView());
      case RouteName.favourite:
        return MaterialPageRoute(builder: (_)=>Favourite());
      case RouteName.user:
        return MaterialPageRoute(builder: (_)=>UserDetails());
      case RouteName.explore:
        return MaterialPageRoute(builder: (_)=>Explore());
      case RouteName.navbar:
        return MaterialPageRoute(builder: (_)=>BottomBar());
      case RouteName.forgot:
        return MaterialPageRoute(builder: (_)=>ForgotPassword());
      case RouteName.addBlog:
        return MaterialPageRoute(builder: (_)=>AddBlog());
      // case RouteName.postDetailsScreen:
      // return MaterialPageRoute(builder: (_)=>PostDetailsScreen());

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