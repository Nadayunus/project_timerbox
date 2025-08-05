import 'package:flutter/material.dart';
import 'package:project_timerbox/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

   TextEditingController nameController=TextEditingController();
   TextEditingController emailController=TextEditingController();
   TextEditingController passwordController=TextEditingController();
   String? email;
   String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(preferredSize: Size.fromHeight(80), 
           child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom:Radius.circular(30)),color: const Color.fromARGB(255, 14, 114, 45)),
            child: SafeArea(
              child: Center(
                  child: Text('SIGN UP',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            )),
           )
           ),
      body:Stack(
           children:[ 
            Image(image: AssetImage('assets/login.jpg'),width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
            Positioned(
              top: 165,
              left: 18,
              right: 18,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),),
                labelText: 'Full Name',
                hintText: 'Enter your name',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 34, 77, 36)),
                filled: true,
                fillColor: const Color.fromARGB(255, 231, 251, 231),
              ),)),
            Positioned(
                top: 243,
                left: 18,
                right: 18,
                child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),),
                labelText: 'Email',
                hintText: 'Enter your email',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 34, 77, 36)),
                filled: true,
                fillColor: const Color.fromARGB(255, 231, 251, 231),
              ))),
              Positioned(
                top: 320,
                left: 18,
                right: 18,
                child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),),
                labelText: 'Password',
                hintText: 'Enter your password',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 34, 77, 36)),
                filled: true,
                fillColor: const Color.fromARGB(255, 231, 251, 231),
              ))),
            Positioned(
              top: 420,
              left: 120,
              right: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: ()async{
                  String name=nameController.text;
                  String email=emailController.text;
                  String password=passwordController.text;
                  if(email.isEmpty || !email.contains('@')){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter a valid email')));return;
                  }
                  if(password.isEmpty || password.length<6){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Atleast 6 characters neeeded')));return;
                  }
                  try{
                  final prefs=await SharedPreferences.getInstance();
                      prefs.setString('SavedEmail', email);
                      prefs.setString('savedPassword', password);
                      prefs.setString('name', name);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create account,try again')));
                  }
                },child: Text('SIGN UP',style: TextStyle(color: const Color.fromARGB(255, 96, 21, 16),fontWeight: FontWeight.bold,fontSize: 16)
              ))),
            Positioned(
                    top: 487,
                    left: 12,
                    right: 12,
                    child: Column(
                    children: [
                      Row(
                        children: [
                        const Expanded(child: Divider( color: Colors.black, thickness: 1.2,)),
                        const SizedBox(width: 8),
                        const Text('Sign In With',style: TextStyle(color: Colors.black,fontSize:18,fontWeight:FontWeight.bold ),),
                        const SizedBox(width: 8),
                        const Expanded(child: Divider(color: Colors.black, thickness: 1.2,))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(children: [
                        SizedBox(width: 90,),
                        const Icon(Icons.facebook,size: 35,color: Color.fromARGB(255, 17, 68, 110),),
                        SizedBox(width: 60,),
                        const Icon(Icons.api,size: 35,color: Color.fromARGB(255, 110, 22, 16),),
                        SizedBox(width: 60,),
                       const Icon(Icons.apple,size: 35,)
                      ],)
                    ],
              )),
        ],
      ),
      // bottomNavigationBar: Container(
      //     height:40, // Adjust height as needed
      //     color: Colors.white, // Background color
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //           Icon(Icons.settings, color: Colors.black), // Hamburger menu icon
      //           Icon(Icons.check_box_outline_blank,size: 18, color: Colors.black),  // Home icon
      //           Icon(Icons.arrow_left,size: 40, color: Colors.black), // Back icon
      //     ],
      //   ),
      // ),
    );
  }
}