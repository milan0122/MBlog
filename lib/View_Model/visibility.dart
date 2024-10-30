import 'package:flutter/cupertino.dart';

class PassVisibility with ChangeNotifier{
   bool _obscureText = true;
  bool get obscureText => _obscureText;
  void toggleObscureText(){
    _obscureText = ! _obscureText;
    return notifyListeners();
  }

}