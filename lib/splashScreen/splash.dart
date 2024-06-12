import 'dart:async';

import 'package:flutter/material.dart';
import 'package:njeve/resources/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 3200), () async {
      openMe();
    });

    return Scaffold(
      backgroundColor: ColorList.backgroundColor,
        body: Center(
          child: SizedBox(
            height: (MediaQuery.of(context).size.height / 2) + 80,
            width: (MediaQuery.of(context).size.width / 2) + 80,
            child: Image.asset("images/logo.png"),
          ),
        ));

  }

  void openMe() async {
    final prefs = await SharedPreferences.getInstance();
    final getIn = prefs.getBool('first') ?? false;

    openHome(landingPage: getIn);
  }

  void openHome({bool landingPage = false}) {
    // if (getRole == "auth") {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const Login()));
    // }else if(getRole == "Basic User")  {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHolder()));
    // }
  }


}
