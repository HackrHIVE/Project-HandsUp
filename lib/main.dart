import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: handleHomePage(),
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
        return loginHome();
      },
  );
}