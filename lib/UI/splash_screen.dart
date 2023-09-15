import 'package:firstproject/FirebaseServices/splashService.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/FirebaseServices/splashService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashService splashScreen = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Resolute AI Software Pvt Ltd'),
        ),
      ),
    );
  }
}
