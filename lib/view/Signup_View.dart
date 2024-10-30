import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mblog/Utils/Components/RoundButton.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/Utils/utils.dart';
import 'package:mblog/View_Model/visibility.dart';
import 'package:provider/provider.dart';
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose(){
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void signup(){
    if(_formkey.currentState!.validate()){
      setState(() {
        loading = true;
      });
      _auth.createUserWithEmailAndPassword(email: emailController.text.toString(),
          password: passwordController.text.toString()
      ).then((value){
        setState(() {
          loading = false;
        });
        Utils.toastMessage('Register Successfully');
        Navigator.pushNamed(context, RouteName.login);
      }).onError((error,StackTrace){
        setState(() {
          loading = false;
        });
        Utils.toastMessage(error.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    focusNode: emailFocusNode,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                    onFieldSubmitted: (value){
                      Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter you email';
                      }
                      else{return null;}
                    },
                  ),

                ),
                SizedBox(height: 20,),
                Consumer<PassVisibility>(builder: (context,value,child){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      obscureText: value.obscureText,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                              onTap: (){
                                value.toggleObscureText();
                              },
                              child: Icon(value.obscureText?Icons.visibility_off:Icons.visibility))
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter your password';
                        }
                        else if(!RegExp(r'[A-Z]').hasMatch(value)){
                          return 'Password must contain at least one uppercase letter';
                        }
                        else if(!RegExp(r'[a-z]').hasMatch(value)){
                          return 'Password must contain at least one lowercase letter';
                        }
                        else if(!RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\{\}\[\]:;<>,\./?]').hasMatch(value)){
                          return "password must contain at least one special character";
                        }
                        else{return null;}
                      },
                    ),

                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 40,),
          RoundButton(title: 'SignUp',
              loading: loading,
              onPress: (){
            signup();
          }),
          SizedBox(height: 10,),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, RouteName.login);

          },
              child:Text("Already have an Account? LogIn",style: TextStyle(color: Colors.black),)
          )


        ],
      ),
    );
  }
}
