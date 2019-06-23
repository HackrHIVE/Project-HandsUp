import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class addTrainee extends StatefulWidget{
  _addTraineeState createState()=> _addTraineeState();
}

class _addTraineeState extends State<addTrainee>{

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

  final formkey=new GlobalKey<FormState>();
  Firestore store = Firestore.instance;
  String nameTrainee,degreeTrainee,sectionTrainee,uidTrainee,imgTrainee;

  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  createTrainee()async{
    if (checkFields()){
      debugPrint('CheckFields : true');
      var fireAuth = FirebaseAuth.instance;
      fireAuth.currentUser().then((onValue)  async{

          // dataset = new List();
          var firestore = Firestore.instance;
          String emailID = onValue.email;
          await firestore.collection('teachers').document(emailID).collection('trainees').document().setData({
            'Degree':degreeTrainee,
            'Name':nameTrainee,
            'Section':sectionTrainee,
            'img':imgTrainee
            }).then((_){
              Navigator.pushReplacementNamed(context, '/mainScreen');
            });
          // QuerySnapshot refDoc = await firestore.collection('teachers').document(emailID).collection('trainees').;
          // for(DocumentSnapshot x in refDoc.documents.toList()){
          //   dataset.add(userdata.fromSnapshot(x));
          // }
          // dataset = refDoc.documents;
          // debugPrint('found email');
          // return refDoc.documents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: (){
              Alert(
                type: AlertType.none,
                context: context,
                title: "Trainee Info",
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    _input('required name', false, 'Enter Trainee\'s name', 'Chirag Rawal', nameTrainee),
                    SizedBox(
                      height: 10,
                    ),
                    _input('required degree', false, 'Enter Trainee\'s Degree', 'B.E', degreeTrainee),
                    SizedBox(
                      height: 10,
                    ),
                    _input('required section', false, 'Enter Trainee\'s Section', '17AITCC2', sectionTrainee),
                    
                    SizedBox(
                      height: 10,
                    ),_input('required uid', false, 'Enter Trainee\'s UID', '17BCS4132', uidTrainee),
                    
                    SizedBox(
                      height: 10,
                    ),_input('required img', false, 'Enter Trainee\'s DP ImgURL', 'img.jpg', imgTrainee),
                  ],
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "Add Trainee",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20),
                    ),
                    onPressed: createTrainee
                    // width: 50,
                  )
                ]).show();

            },
          )
        ],
        title: Text('Add new Trainee'),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.grey
                ),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/mainScreen');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.blue,
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
      body: Center(
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
            return Center(
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
            );
              },
            );
          },
        )
      ),
      )
    );
  }

}

Widget _input(String validation,bool ,String label,String hint, save ){

    return new TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),

      ),
      obscureText: bool,
      validator: (value)=>
      value.isEmpty ? validation: null,
      onSaved: save ,

    );

  }