import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'mainScreen.dart';

class loginHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Login_Signup();
  }

}

class Login_Signup extends State<loginHome>{

  String imgBackground = 'assets/images/back.jpg';

  final _formKey = GlobalKey<FormState>();
  String email,password;
  bool isVerfied = false;
  String toShowFlatButton = 'Refresh Status';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    @override
Future<String> signIn(String email, String password) async {
    FirebaseUser user = await  _firebaseAuth.signInWithEmailAndPassword(email: email, password:password);
    if (user.isEmailVerified) return user.uid;
    return null;
}

    return Scaffold(
      key: _scaffKey,
//      appBar: AppBar(
//        title: Text('Attendance'),
//      ),
      body: Stack(
      
              children: <Widget>[
    Hero(
  
              tag: '_animHero',
  
              child: Container(
  
                height: double.infinity,
  
                width: double.infinity,
  
              decoration: BoxDecoration(
  
                  image: DecorationImage(
  
                      fit: BoxFit.cover,
  
                      image: AssetImage(imgBackground),
  
  //            image: NetworkImage('https://www.microrecord.com/wp-content/uploads/2014/04/ecm-for-schools.jpg'),
  
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7),  BlendMode.darken)
  
                  )
  
              ),
  
              
  
            ),
  
          ),
        Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                          borderRadius: BorderRadius.circular(6.0) ,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6.0))
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Empty Input not allowed!';
                        }
                      },

                      onSaved: (value){
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          ),
                          borderRadius: BorderRadius.circular(6.0) ,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6.0))
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Empty Input not allowed!';
                        }
                        else if(value.length<8){
                          return 'Short Password!';
                        }
                      },
                      onSaved: (value){
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: Colors.white)
                    ),
                    textColor: Colors.white,
                    child: Text('Login'),
                    onPressed: () async {
                      final form = _formKey.currentState;
                      if(form.validate()){
                        form.save();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(),);
                        });
                        // Future<String> userUID = signIn(email, password);

                        _firebaseAuth.signInWithEmailAndPassword(email: email, password:password).then((FirebaseUser user){
                          if(!user.isEmailVerified){
                            user.sendEmailVerification();
                            showSnackPlz(context);
                          }
                          else{
                            Navigator.pushReplacementNamed(context, '/mainScreen');
                          }
                        });
                        
          //               FirebaseUser user = await FirebaseAuth.instance.currentUser();
          //               if(userUID!=null){
          //                 debugPrint('isVerified : '+user.isEmailVerified.toString());
          //                 if(!user.isEmailVerified){
          //                   user.sendEmailVerification();
          //                   showSnackPlz(context);
          //                 }
          //                 else{
          //                   Navigator.popAndPushNamed(context, '/mainScreen');
          //                   // Navigator.pop(context);
          //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>mainScreen()));
          //                 }
          //               }
          //               else{
          //                 user.sendEmailVerification();
          //                 showSnackPlz(context);
          // //                 final SnackBar snackMe = SnackBar(
          // //   content: Text('Verification Email Sent, please verify your Email address!'),);
          // // _scaffKey.currentState.showSnackBar(snackMe);
          //               }
                        // FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((onValue) {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>mainScreen(onValue)));
                        // }).catchError((onError){
                        //   print(onError.toString());
                        // });
                      }
                      else{
                        final snack = SnackBar(
                          action: SnackBarAction(
                            onPressed: (){
                              SnackBarClosedReason.swipe;
                            },
                            label: 'Invalid Credentials',
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snack);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
],
      ),
    );
  }

  showSnackPlz(BuildContext context) {
          final SnackBar snackMe = SnackBar(
            content: Text('Verification Email Sent, please verify your Email address!'),);
          _scaffKey.currentState.showSnackBar(snackMe);

  }

}