import 'dart:js';

import 'package:dart_news/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigate();
  }

  _navigate() async {
    // await Future.delayed(Duration(milliseconds: 1000), () {});
    // Navigator.pushReplacement(
    //     this.context, MaterialPageRoute(builder: ((context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Splash Screen"),
      ),
    );
  }
}
