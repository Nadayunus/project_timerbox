import 'package:flutter/material.dart';
import 'package:project_timerbox/screens/sign.dart';
import 'package:project_timerbox/screens/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isLog=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
      appBar:PreferredSize(preferredSize: Size.fromHeight(80), 
           child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom:Radius.circular(30)),color: const Color.fromARGB(255, 14, 114, 45)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              
            )),
           )
           ),
      body:Stack(
           children:[ 
            Image(image: AssetImage('assets/login.jpg'),width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
            Positioned(
              top: 180,
              left: 18,
              right: 18,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),),
                labelText: 'email',
                hintText: 'Enter your email',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 34, 77, 36)),
                filled: true,
                fillColor: const Color.fromARGB(255, 231, 251, 231),
              ),)),
            Positioned(
                top: 254,
                left: 18,
                right: 18,
                child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),),
                labelText: 'password',
                hintText: 'Enter your password',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 34, 77, 36)),
                filled: true,
                fillColor: const Color.fromARGB(255, 231, 251, 231),
              ))),
            Positioned(
              top: 340,
              left: 120,
              right: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: ()async{
                  String email=emailController.text;
                  String password=passwordController.text;
                  if(email.isEmpty || !email.contains('@')){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter a valid email')));return;
                  }
                  if(password.isEmpty || password.length<6){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Atleast 6 characters neeeded')));return;
                  }
                  final prefs=await SharedPreferences.getInstance();
                  prefs.setBool('isLogged', isLog);
                  String? savedEmail=prefs.getString('SavedEmail');
                  String? savedPassword=prefs.getString('savedPassword');
                  if(savedEmail==email && savedPassword==password){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successfully')));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid password or email')));
                  }
                  }, 
                  child: Text('LOGIN',style: TextStyle(color: const Color.fromARGB(255, 96, 21, 16),fontWeight: FontWeight.bold,fontSize: 16)))),
                Positioned(
                    top: 420,
                    left: 12,
                    right: 12,
                    child: Column(
                    children: [
                      Row(
                        children: [
                        const Expanded(child: Divider(color: Color.fromARGB(255, 24, 116, 61),)),
                        const SizedBox(width: 8),
                        const Text('OR',style: TextStyle(color: Colors.black,fontSize:16,fontWeight:FontWeight.bold ),),
                        const SizedBox(width: 8),
                        const Expanded(child: Divider(color: Color.fromARGB(255, 24, 116, 61))),
                        
                        ],
                      ),  
                    ],
                  )),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.58,
                      left:  MediaQuery.of(context).size.width * 0.23, 
                      child: Text("Don't have an account?",style: TextStyle(color: Colors.black,fontSize:19,fontWeight: FontWeight.bold),)),
                  Positioned(
                    top:  MediaQuery.of(context).size.height * 0.6, 
                    left:MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    child: TextButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sign()));}, child:Text('Create an account',style: TextStyle(color: const Color.fromARGB(255, 17, 54, 84),fontSize: 20,fontWeight: FontWeight.bold),) ))
        ],
      ),

    );
  }
}
