import 'dart:async';
import 'package:firstproject/UI/auth/loginScreen.dart';
import 'package:flutter/material.dart';

class SplashService{
  void isLogin(BuildContext context){

    Timer(Duration(seconds: 3),()=> Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())));


  }
}