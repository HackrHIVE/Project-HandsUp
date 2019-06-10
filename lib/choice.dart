import 'package:attendance/Login.dart';
import 'package:attendance/Signup.dart';
import 'package:flutter/material.dart';

class chooser extends StatelessWidget{


  String loginText = 'Login';
  String signupText = 'Signup';
  String imgBackground = 'https://d3i6fh83elv35t.cloudfront.net/newshour/app/uploads/2015/03/78816800-1024x683.jpg';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imgBackground),
//            image: NetworkImage('https://www.microrecord.com/wp-content/uploads/2014/04/ecm-for-schools.jpg'),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7),  BlendMode.darken)
          )
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Hands Up',
                  style: TextStyle(
                      fontFamily: 'Abril Fatface',
                      fontWeight: FontWeight.bold,  
                      color: Colors.white,
                      fontSize: 32
                  ),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.width*0.08,
            ),
            Hero(
                // transitionOnUserGestures: true,
                tag: '_animHero',
                child: Container(
                height: MediaQuery.of(context).size.height*0.08,
                width: MediaQuery.of(context).size.width*.40,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  splashColor: Colors.black,
                  child: Text('LOGIN',
                  style: TextStyle(color: Colors.white,fontSize: 20),),
                  onPressed: (){
                    Navigator.pushNamed(context,'/loginHome');
                  },
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.02),
            Hero(
                // transitionOnUserGestures: true,
                tag: '_animHero_',
                child: Container(
                height: MediaQuery.of(context).size.height*0.08,
                width: MediaQuery.of(context).size.width*.40,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  splashColor: Colors.black,
                  child: Text('SIGNUP',
                  style: TextStyle(color: Colors.white,fontSize: 20,),),
                  onPressed: (){
                    Navigator.pushNamed(context,'/signupHome');
                  },
                ),
              ),
            )
          ],
        ),
          ),
      )
    );
  }

}