import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(80), 
        child: Container(
          decoration: BoxDecoration( color: const Color.fromARGB(255, 10, 90, 35),borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),),
          child: SafeArea(
            child: Center(
              child: Row(
                children: [
                   SizedBox(width: 8,),
                   IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: Colors.white,size: 24,)),
                   SizedBox(width: 65,),
                   const Text('SETTINGS',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,),),
                ],
              )
            )),
          ),
        ),
      body: Padding(padding: EdgeInsets.all(20),
         child: Column(
          children: [
              ListTile(
                title: Text('Notification'),
                leading: Icon(Icons.notifications_active),
              ),
              SizedBox(height: 26,),
              ListTile(
                title: Text('Nothing here yet',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                subtitle: Text('Try pinning List or a Community'),
              )      
          ],
         ),
      ),
    );    
  }
}