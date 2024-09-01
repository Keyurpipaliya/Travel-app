import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/custom_ber.dart';
import 'package:travelingapp/Screen/login.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checklogin()async{

    SharedPreferences prefs =await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   BottomBar(),));
      }
    else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const  Login(),));
      }

  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),() {
      checklogin();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const  Welcome(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200, // Set your desired height
          width: 200, // Set your desired width
          child: Lottie.asset('assets/images/travelwork.json'),
        ),
      ),
    );
  }
}


