import 'dart:async';

import 'package:fitness_finder/Screens/home.dart';
import 'package:fitness_finder/Utils/Colors.dart';
import 'package:fitness_finder/Utils/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => Home()
            )
         )
         
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackbg,
        body: SafeArea(
          
          child:Center(
            child: Image.asset(logo),
          )
),
    );
  }
}