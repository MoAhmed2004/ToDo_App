import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(
      seconds: 3
    ),
          () {
      FirebaseAuth.instance.currentUser==null
          ?Navigator.pushReplacementNamed(context, LoginScreen.routeName)
          :Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } ,);
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png",
        height: height*0.5,
        width: width*0.4,
        ),
      ).animate().fadeIn(
        duration: Duration(seconds: 1),
      ).then().fadeOut(
        duration: Duration(seconds: 2),
      ),
    );
  }
}
