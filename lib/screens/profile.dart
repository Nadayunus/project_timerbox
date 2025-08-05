import 'package:flutter/material.dart';
import 'package:project_timerbox/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? email;
  String? password;
  @override
  void initState(){
    super.initState();
   display();
}
  Future<void> display() async{
  final prefs=await SharedPreferences.getInstance();
  setState(() {
     name=prefs.getString('name');
     email=prefs.getString('SavedEmail');
     password=prefs.getString('savedPassword');
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(80), 
           child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom:Radius.circular(30)),color: const Color.fromARGB(255, 12, 90, 37)),
            child: SafeArea(
              child: Center(
                  child: Text('PROFILE',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              ),
           )
          ),
        ),       
        body: Padding(padding: EdgeInsets.all(20),
            child:Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                           SizedBox(width: 16),
                           Text("Name:", style: TextStyle(fontWeight: FontWeight.bold)),
                           SizedBox(width: 8),
                           Expanded(child: Text(name?? 'No name sett')),
                       ],
                      )
                    )
                  ),
                
                 Card(
                    child: Padding(padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.email, size: 24),
                        SizedBox(width: 16),
                        Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Expanded(child: Text(email?? 'No email sett')),
                      ],
                    ),)
                  ),
                  SizedBox(height: 35),
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));}, child: Text('Settings',style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold)))
                ],
              )
            )
        )
      
    ); 
  }
}