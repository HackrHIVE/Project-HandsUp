import 'package:attendance/choice.dart';
import 'package:attendance/main.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
class mainScreen extends StatefulWidget{


  // Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

  @override
  _mainState createState() => _mainState();

}

class _mainState extends State<mainScreen>{

  // Future<FirebaseUser> user;

  // _mainState(this.user);

  final Scaff = GlobalKey<ScaffoldState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back,
        color: Colors.blue,),
        title: Text('HandsUp'),
        actions: <Widget>[
          InkWell(
            onTap: (){
              _firebaseAuth.signOut();
              debugPrint('Successfully signed Out!');
              Navigator.push(context, MaterialPageRoute(builder: (context)=>chooser()));
            },
            child: Icon(
            Icons.power,
            color: Colors.teal,
          ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async{
        Future.value(false);
      },
              child: Center(
          child: Column(
            children: <Widget>[
              
              Cards(),

            ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatefulWidget{
  @override
  CardState createState()=>CardState();

}

class CardState extends State<Cards> with TickerProviderStateMixin{

  List<String> welcomeImages = [
    "assets/images/back.jpg",
    "assets/images/back2.jpg",
    "assets/images/back3.jpg",
    "assets/images/back4.jpeg",
    "assets/images/back5.jpg",
    "assets/images/back6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: new TinderSwapCard(
            orientation: AmassOrientation.BOTTOM,
            totalNum: 6,
            stackNum: 3,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            // swipeCompleteCallback: ,
            // swipeCompleteCallback: SwipeCard,
            cardBuilder: (context, index) => Card(
                  child: Image.asset('${welcomeImages[index]}'),
                  
                ),
          )));
  }
}