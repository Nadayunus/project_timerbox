import 'package:flutter/material.dart';
import 'package:project_timerbox/screens/chart.dart';
import 'package:project_timerbox/screens/home.dart';
import 'package:project_timerbox/screens/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _BottomNavState();
}
class _BottomNavState extends State<MainPage> {
  int currentIndex=1;
  final List<Widget> pages=[
    const Profile(),
    const Home(),
    const ChartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
         items: const[
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.data_usage),label: 'Chart') ],
          
         backgroundColor: Color.fromARGB(255, 105, 160, 118),
         selectedItemColor: Colors.white,
         unselectedItemColor: Colors.white70,
      ),
    );
  }
}