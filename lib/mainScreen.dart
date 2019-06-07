import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class mainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
      body: Center(child: RaisedButton(
        onPressed: () async {
  
          await FirebaseAuth.instance.signOut();
        },
        child: Text('Logout',style: TextStyle(color: Colors.white),),
        elevation: 5.00,
        color: Colors.deepOrange,
        splashColor: Colors.black,
      ),),
    );
  }

}