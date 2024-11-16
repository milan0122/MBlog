import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
class SplashServices{
  static void isLogin(BuildContext context){
   final _auth = FirebaseAuth.instance;
   final user = _auth.currentUser;

   if(user !=null){
     Future.delayed(const Duration(seconds: 3),(){
       Navigator.pushNamed(context, RouteName.home);
     });
   }
   else{
     Future.delayed(const Duration(seconds: 3),(){
       Navigator.pushNamed(context, RouteName.medScreen);
     });
   }

  }

}