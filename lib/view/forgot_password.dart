import 'package:flutter/material.dart';
import 'package:mblog/Utils/Components/RoundButton.dart';
import 'package:mblog/Utils/utils.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MBLOG'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Forgot Password',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail),
              ),
            ),

          ),
          SizedBox(height: 30,),
          RoundButton(title: 'Reset Password', onPress: (){

          })


        ],
      ),
    );
  }
}
