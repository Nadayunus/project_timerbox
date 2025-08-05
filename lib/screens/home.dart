import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_timerbox/model/timer.dart';
import 'package:project_timerbox/screens/edit.dart';
import 'package:project_timerbox/screens/login.dart';
import 'package:project_timerbox/services/function.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
 
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationionController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: PreferredSize( 
      preferredSize: Size.fromHeight(80),
       child: Container(
        decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        color: Color.fromARGB(255, 14, 114, 45), ),
         child: SafeArea(
          child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Expanded(
                 child: Center(
                   child: Text(
                    'DAY TRACKER',
                    style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
           IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLogged', false);
                await prefs.remove('SavedEmail');
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login()),);
              },
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ],
         ),
        ),
       ),
      ),
     ),
      body: ValueListenableBuilder(                        //BODY
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final data = value[index];
                  return SizedBox(
                    height: 75,
                    child: Card(
                      color: Colors.green[100],
                      child: ListTile(
                        title: Text(
                          data.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.delete,
                                color: const Color.fromARGB(255, 148, 39, 32),
                              ),
                              onTap: () async {
                                final shoulDelete = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Delete item'),
                                    content: Text(
                                      'Are you sure you want to delete this item?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                                if (shoulDelete == true) {
                                  await deleteData(index);
                                }
                              },
                            ),
                            InkWell(
                              child: Icon(
                                Icons.note_add,
                                color: const Color.fromARGB(255, 26, 72, 109),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Edit(
                                      title: data.title,
                                      description: data.description,
                                      duration: data.duration,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){showMyDialog();},child: Icon(Icons.add),),
    );
  }
  Future<void> showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ADD NOTES',style: TextStyle(color: const Color.fromARGB(255, 138, 35, 27)),),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Title',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: durationionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Duration (in minutes)',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async{
              try {
                final minutes = int.tryParse(durationionController.text);
                final prefs = await SharedPreferences.getInstance();
                final userMail = prefs.getString('SavedEmail');
                if (userMail == null || userMail.isEmpty) {
                  throw Exception('User email not found,try again.');
                }
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    minutes == null) {
                  throw Exception('Please fill all fields correctly');
                }
                final save = Activity(
                  title: titleController.text,
                  description: descriptionController.text,
                  duration: minutes,
                  userEmail: userMail,
                );
                await addData(save);
                Fluttertoast.showToast(
                  msg: 'Task Added',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: const Color.fromARGB(255, 249, 250, 249),
                  textColor: Colors.black
                );
                titleController.clear();
                descriptionController.clear();
                durationionController.clear();
                if (mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Here :${e.toString()}',
                      ),
                    ),
                  );
                }
              }
            },
            child: Text('Add',style: TextStyle(color: const Color.fromARGB(255, 138, 35, 27)),),
          ),
           TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel',style: TextStyle(color: const Color.fromARGB(255, 138, 35, 27)),),
          ),
        ],
      ),
    );
  }
}