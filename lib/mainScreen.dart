import 'package:attendance/choice.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
class mainScreen extends StatefulWidget{
  @override
  _mainState createState() => _mainState();
}

class _mainState extends State<mainScreen>{

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
          child: Cards(),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.blue
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.grey,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/addTrainee');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                color: Colors.grey,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/user');
                },
                icon: Icon(Icons.verified_user),
              ),
            ),
          ],
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

  // List<userdata> dataset;
  Future getListData() async{
    var fireAuth = FirebaseAuth.instance;
    fireAuth.currentUser().then((onValue)  async{

        // dataset = new List();
        var firestore = Firestore.instance;
        String emailID = onValue.email;
        QuerySnapshot refDoc = await firestore.collection('teachers').document(emailID).collection('trainees').getDocuments();
        // for(DocumentSnapshot x in refDoc.documents.toList()){
        //   dataset.add(userdata.fromSnapshot(x));
        // }
        // dataset = refDoc.documents;
        debugPrint('found email');
        return refDoc.documents;
    });
     var firestore = Firestore.instance;
    QuerySnapshot refDoc = await firestore.collection('teachers').document('rawalchirag2000@gmail.com').collection('trainees').getDocuments();
        
    return refDoc.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getListData();
    });
  }

  // List<userdata> dataset = [
  //   new userdata('Name1', "assets/images/back.jpg"),
  //   new userdata('Name2', "assets/images/back2.jpg"),
  //   new userdata('Name3', "assets/images/back3.jpg"),
  //   new userdata('Name4', "assets/images/back4.jpeg"),
  //   new userdata('Name5', "assets/images/back5.jpg"),
  //   new userdata('Name 6', "assets/images/back6.png"),
  // ];

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: getListData(),
          builder: (_,snapShot){
            if(snapShot.connectionState==ConnectionState.waiting){
              return Text('Loading ... ');
            }
            return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (_,index){
                String item=snapShot.data[index].data['img'];
            return Dismissible(
              
              key: Key(item),
              onDismissed: (DismissDirection dir){
                debugPrint('i:'+index.toString());
                // setState(()=>snapShot.removeAt(i));
                debugPrint(dir==DismissDirection.startToEnd?"${snapShot.data[index].data['Name']}->Present":"${snapShot.data[index].data['Name']}->Absent");
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                      content: Text(dir==DismissDirection.startToEnd?"${snapShot.data[index].data['Name']} Present":"${snapShot.data[index].data['Name']} Absent"),
                  ),
                );
              },
              background: Container(
                child: Icon(Icons.rotate_right),
                color: Colors.green,
                alignment: Alignment.centerLeft,
              ),
              secondaryBackground: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Icon(Icons.warning),
                ),
                color: Colors.red,
                alignment: Alignment.centerRight,
              ),
              child: Center(
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.width*0.9,
                    width: MediaQuery.of(context).size.width*0.9,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width*0.7,
                          width: MediaQuery.of(context).size.width*0.7,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.35),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapShot.data[index].data['img'])
                            )
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width*0.05,
                        ),
                        Center(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                snapShot.data[index].data['Name'],
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                snapShot.data[index].data['Degree'],
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                snapShot.data[index].data['Section'],
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )  

                ),
              ),
            );
              },
            );
          },
        )
      ),
    );
  }
}

// class traineesData{
//   String name,uid,section,imgURL,degree;
// }

class userdata{

  String name;
  String imgURL;
  String tech;
  String job;
  DocumentReference reference;

  userdata(this.name,this.tech,this.job,this.imgURL);

  userdata.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map["Name"];
    imgURL=map["img"];
    tech = map['technology'];
    job = map['job'];
  }

  userdata.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}