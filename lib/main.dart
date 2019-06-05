import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_Signup();
  }

}

class Login_Signup extends State<homepage>{

  final _formKey = GlobalKey<FormState>();
  String email,password;

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
            image: NetworkImage('https://d3i6fh83elv35t.cloudfront.net/newshour/app/uploads/2015/03/78816800-1024x683.jpg'),
//            image: NetworkImage('https://www.microrecord.com/wp-content/uploads/2014/04/ecm-for-schools.jpg'),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7),  BlendMode.darken)
          )
        ),
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
                      fontSize: 32
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
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
                      labelStyle: TextStyle(color: Colors.white),
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
                      color: Colors.white
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
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Empty Input not allowed!';
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
                  onPressed: (){
                    final form = _formKey.currentState;
                    if(form.validate()){
                      form.save();
                      Alert(
                          type: AlertType.success,
                          context: context,
                          title: "Your info",
                          desc:
                          "Email : ${email}\n"
                              "Password : ${password}",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20,
                                    backgroundColor: Color.fromRGBO(7, 156, 255, 100)),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              width: 50,
                            )
                          ]
                      ).show();
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