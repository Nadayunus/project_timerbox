import 'package:flutter/material.dart';
import 'package:project_timerbox/model/timer.dart';
import 'package:project_timerbox/services/function.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Edit extends StatefulWidget {
  String title;
  String description;
  int duration;
  int index;
  Edit({required this.title,required this.description,required this.index,required this.duration});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController durationController=TextEditingController();

  @override
  void initState(){
    titleController=TextEditingController(text: widget.title);
    descriptionController=TextEditingController(text: widget.description);
    durationController=TextEditingController(text:widget.duration.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(border: OutlineInputBorder()),),
                SizedBox(height: 20,),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(border: OutlineInputBorder()),),
                SizedBox(height: 20,),
              TextField(
                controller: durationController,
                decoration: InputDecoration(border: OutlineInputBorder()),),
                SizedBox(height: 23),
              ElevatedButton(onPressed: ()async{
                try{
                final minutes=int.tryParse(durationController.text) ?? 0;
                final userEmail = (await SharedPreferences.getInstance()).getString('SavedEmail');
                if (userEmail==null) throw Exception("User not logged in");
                final updatedActivity=Activity(title: titleController.text,description: descriptionController.text,duration:minutes,userEmail:userEmail,
                );
                 await updateData(widget.index, updatedActivity);
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully')));
                }
                Navigator.pop(context);
              }catch(e){
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error : ${e.toString()}')));
                }
              }
              }, child: Text('UPDATE')),
            ],
          ),
        ),
      ),
    );
  }
}