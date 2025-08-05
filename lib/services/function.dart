import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_timerbox/model/timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<Activity>> valueNotifier = ValueNotifier([]);

Future<String> currentUserEmail()async{
  try{
  final prefs=await SharedPreferences.getInstance();
   final mail= prefs.getString('SavedEmail');
   if(mail==null|| mail.isEmpty){
    throw Exception('User not logged in properly');
   }return mail;
  }catch(e){
    debugPrint('Error getting user email: $e');
    rethrow;                                          // Sends the same error to the place where this function was called 
  }
}

Future<void> getData() async {
  final userMail=await currentUserEmail();
  final box = await Hive.openBox<Activity>('UserBox');
  valueNotifier.value = List.from(box.values.where((activity)=> activity.userEmail==userMail).toList());
  valueNotifier.notifyListeners();
}

Future<void> addData(Activity value) async {
  try{
  final userMail=await currentUserEmail();
  final box = await Hive.openBox<Activity>('UserBox');
  final userActivity=Activity(title: value.title, description: value.description, duration: value.duration, userEmail: userMail);
  await box.add(userActivity);
  await getData();
 }catch(e){
  debugPrint('Data is not adding $e');
  rethrow;
 }
}

Future<void> deleteData(int index) async {
  try{
  final userMail= await currentUserEmail();
  final box = await Hive.openBox<Activity>('UserBox');
  final userActivity=box.values.where((activity)=>activity.userEmail==userMail).toList();
  final actualIndex=box.values.toList().indexOf(userActivity[index]);
  await box.deleteAt(actualIndex);
  await getData();
  }catch(e){
    debugPrint('Not deleted $e');
  }
}

Future<void> updateData(int index, Activity value) async {
  try{
  final userMail=await currentUserEmail();
  final box = await Hive.openBox<Activity>('UserBox');
  final userActivity=box.values.where((activity)=>activity.userEmail==userMail).toList();
  final actualIndex=box.values.toList().indexOf(userActivity[index]);
  final updatedActivity=Activity(title: value.title, description: value.description, duration: value.duration, userEmail:userMail);
  await box.putAt(actualIndex, updatedActivity);
  await getData(); 
  }catch(e){
    debugPrint('Error in updating data $e');
  }
}