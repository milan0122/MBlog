import 'package:flutter/material.dart';
import 'package:mblog/view/Signup_View.dart';
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignupView()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Image(image: AssetImage('assets/blog_logo.jpeg')),
      ),
    );
  }
}
