import 'package:flutter/material.dart';
import 'package:project_timerbox/screens/main_page.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
          
            image: AssetImage('assets/light.jpg'),
            height:double.infinity,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            top: 280,
            left: 40,
            child: Text(
              'Welcome Back',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 345,
            left: MediaQuery.of(context).size.width * 0.10,
            child: Text(
              'Every Second Shapes Your Succcess',
              style: TextStyle(
                color: const Color.fromARGB(255, 108, 14, 14),
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            top: 630,
            left: 70,
            right: 70,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 14, 114, 45),
              ),
              child: Text(
                'Getting Started',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
