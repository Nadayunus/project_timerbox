import 'package:hive/hive.dart';
part 'timer.g.dart';
@HiveType(typeId: 0)
class Activity{

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  int duration;
  
  @HiveField(3)
  String userEmail;

  Activity({required this.title,required this.description,required this.duration,required this.userEmail});
}