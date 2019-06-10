import 'package:attendance/Login.dart';
import 'package:attendance/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signupHome extends StatefulWidget{
  @override
  signupState createState()=> signupState();

}

class signupState extends State<signupHome>{

  String imgBackground = 'assets/images/back.jpg';

  final _formKey = GlobalKey<FormState>();
  final _scaffKey = GlobalKey<ScaffoldState>();
  String email,password;
  bool isVerfied = false;
  String toShowFlatButton = 'Refresh Status';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
body: Stack(
  children: <Widget>[
    Hero(
    tag: '_animHero_',
              child: Container(
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
      Form(
          key: _formKey,
          child: Center(
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
                  child: Text('Signup'),
                  onPressed: (){
                    final form = _formKey.currentState;
                    if(form.validate()){
                      form.save();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(),);
                      });
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((onValue) {
                        // onValue.sendEmailVerification();
                        Navigator.pushReplacementNamed(context, '/loginHome');
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>loginHome()));

//                         if(!onValue.isEmailVerified){
//                           Alert(
//                             type: AlertType.warning,
//                             context: context,
//                             title: 'Verify your Email Address',
//                             content: Column(
//                               children: <Widget>[
//                                 Text('Verified Status : ${isVerfied}'),
//                                 SizedBox(
//                                   height: 20,
//                                 ),

//                               ],
//                             ),
//                             buttons: [
//                               DialogButton(
//                                   color: Colors.deepOrange,
//                                   onPressed: () {
// //                                    if(!mounted)
// //                                      return;


//                                     if(!isVerfied){
// //                                      setState(() {
// //
// //                                      });
//                                       onValue.reload();
//                                       isVerfied = onValue.isEmailVerified;
//                                       debugPrint('isVerified : '+isVerfied.toString());
//                                       debugPrint('isVerified(online) : '+onValue.isEmailVerified.toString());
//                                       if(isVerfied){
//                                         toShowFlatButton = 'Continue to Homepage';
//                                       }
//                                     }
//                                     else{
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>mainScreen(onValue)));
//                                     }

// //                                    setState(()  {
// //
// //                                    });
//                                   }, child: Text('${toShowFlatButton}'))
//                             ]
//                           ).show();
//                         }
                      });
                    }
                    else{
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
  ],
)
    );
  }
}