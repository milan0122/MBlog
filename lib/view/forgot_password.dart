import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mblog/Utils/Components/RoundButton.dart';
import 'package:mblog/Utils/utils.dart';
import 'package:mblog/view/login_View.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
              ),
            ),
          ),
          SizedBox(height: 40,),
          RoundButton(title:'Reset Password',
              loading: loading,
              onPress: (){
                setState(() {
                  loading=true;
                });

                auth.sendPasswordResetEmail(email: emailController.text.toString()
                ).then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginView()));
                  setState(() {
                    loading=false;
                  });
                  Utils.toastMessage('We have sent you email to recover password, please check email');
                }).onError((error,StackTrace){
                  setState(() {
                    loading=false;
                  });
                  Utils.toastMessage(error.toString());
                });
              })
        ],
      ),
    );
  }
}
