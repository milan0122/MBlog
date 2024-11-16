import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mblog/Utils/Components/RoundButton.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/Utils/utils.dart';
import 'package:mblog/View_Model/visibility.dart';
import 'package:provider/provider.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose(){
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    if(_formKey.currentState!.validate()){
      setState(() {
        loading = true;
      });
      _auth.signInWithEmailAndPassword(email: emailController.text.toString(),
          password: passwordController.text.toString()
      ).then((value){
        setState(() {
          loading = false;
        });
        Utils.toastMessage('Welcome to blog');
        Navigator.pushNamed(context, RouteName.navbar);
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
            key: _formKey,
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
                      return 'Please Enter your email';
                    }
                    else{
                      return null;
                    }
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
                      else{
                        return null;
                      }
                    },
                  ),

                );
              }),
            ],
          )),

          Align(
            alignment: Alignment.topRight,
            widthFactor: 3,
            child: TextButton(onPressed: (){
              Navigator.pushNamed(context, RouteName.forgot);
            },
                child:Text("Forgot Password?",style: TextStyle(color: Colors.black),)
            ),
          ),
          SizedBox(height: 40,),

          RoundButton(title: 'LogIn', onPress: (){
            login();
          }),
          SizedBox(height: 10,),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, RouteName.signUP);
          },
              child:Text("Don't have an Account? SignUp",style: TextStyle(color: Colors.black),)
          )


        ],
      ),
    );
  }
}
