// import 'package:attendance/AddTrainee.dart';
import 'package:attendance/Login.dart';
import 'package:attendance/Signup.dart';
import 'package:attendance/choice.dart';
import 'package:attendance/userContent.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'addTrainee.dart';
import 'mainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: handleHomePage(),
      routes: {
        '/loginHome':(context)=>loginHome(),
        '/signupHome':(context)=>signupHome(),
        '/choose':(context)=>chooser(),
        '/mainScreen':(context)=>mainScreen(),
        '/addTrainee':(context)=>addTrainee(),
        '/user':(context)=>UserContent(),
      },
    );
  }
}

Widget handleHomePage(){
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context ,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting)
        return Center(child: Text('Loading...'),);
     else if(snapshot.hasData)
       return mainScreen();
      else
        return chooser();
      },
  );
}