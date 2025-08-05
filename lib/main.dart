import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_timerbox/model/timer.dart';
import 'package:project_timerbox/screens/home.dart';
import 'package:project_timerbox/screens/login.dart';
import 'package:project_timerbox/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ActivityAdapter());
  Hive.openBox<Activity>('UserBox');
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splash(),
    );
  }
}