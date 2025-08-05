import 'package:flutter/material.dart';
import 'package:project_timerbox/screens/home.dart';
import 'package:project_timerbox/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    splash(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/no-bg.png'))),
      ),
    )
    );
  }
}

void splash(BuildContext context) async {
  await Future.delayed(Duration(seconds: 3), ()async {
    bool? isLog;
    final prefs=await SharedPreferences.getInstance();
    isLog= prefs.getBool('isLogged');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => isLog ?? false ?   Home() :  Login() ),
    );
  });
}
