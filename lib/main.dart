import 'package:flutter/material.dart';

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
class homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                width: double.infinity,
                child: TextField(
                  cursorWidth: 8.0,
                  enableInteractiveSelection: true,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(),
                    labelText: 'NAME',
                    labelStyle: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 18,

                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(35, 20, 35, 0),
                width: double.infinity,
                child: TextField(
                  cursorWidth: 8.0,
                  enableInteractiveSelection: true,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(),
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 18,

                    ),
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
//                onPressed: (){Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Loggin in!')));},
                child: Container(

                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Text('SUBMIT DETAILS',style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}