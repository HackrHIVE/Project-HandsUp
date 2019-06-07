import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'mainScreen.dart';

class loginHome extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<loginHome> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool isVerfied = false;
  String toShowFlatButton = 'Refresh Status';

  setVerifiedTrue() {
    setState(() {
      isVerfied = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Attendance'),
//      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://d3i6fh83elv35t.cloudfront.net/newshour/app/uploads/2015/03/78816800-1024x683.jpg'),
//            image: NetworkImage('https://www.microrecord.com/wp-content/uploads/2014/04/ecm-for-schools.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.darken))),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    'Attendance Marker',
                    style: TextStyle(
                        fontFamily: 'Abril Fatface',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 32),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Empty Input not allowed!';
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Empty Input not allowed!';
                      } else if (value.length < 8) {
                        return 'Short Password!';
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white)),
                  textColor: Colors.white,
                  child: Text('Login'),
                  onPressed: () {
                    debugPrint('Button Pressed!');
                    final form = _formKey.currentState;
                    debugPrint(form.validate().toString());
                    if (form.validate()) {
                      form.save();

                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password)
                          .then((onValue) async {
                        await onValue.sendEmailVerification();
                        final snack = SnackBar(
                          action: SnackBarAction(
                            label: 'Verification Email Sent!',
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snack);
                        Alert(
                            type: AlertType.warning,
                            context: context,
                            title: 'Verify your Email Address',
                            content: Column(
                              children: <Widget>[
                                Text('Verified Status : ${isVerfied}'),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                  color: Colors.deepOrange,
                                  onPressed: () {
                                    setState(() {
                                      if (!isVerfied) {
                                        onValue.reload();
                                        isVerfied = onValue.isEmailVerified;
                                        debugPrint('isVerified : ' +
                                            isVerfied.toString());
                                        debugPrint('isVerified(online) : ' +
                                            onValue.isEmailVerified.toString());
                                        if (isVerfied) {
                                          toShowFlatButton =
                                              'Continue to Homepage';
                                        }
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    mainScreen()));
                                      }
                                    });
                                  },
                                  child: Text('${toShowFlatButton}'))
                            ]).show();
                      });

//                      Alert(
//                          type: AlertType.success,
//                          context: context,
//                          title: "Your info",
//                          desc:
//                          "Email : ${email}\n"
//                              "Password : ${password}",
//                          buttons: [
//                            DialogButton(
//                              child: Text(
//                                "Ok",
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 20,
//                                    backgroundColor: Color.fromRGBO(7, 156, 255, 100)),
//                              ),
//                              onPressed: () {
//                                Navigator.pop(context);
//                              },
//                              width: 50,
//                            )
//                          ]
//                      ).show();
                    } else {
                      final snack = SnackBar(
                        action: SnackBarAction(
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
      ),
    );
  }
}
