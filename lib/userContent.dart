import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class UserContent extends StatefulWidget{

  _userState createState() => _userState();

}

class _userState extends State<UserContent>{
  
  List<String> tempListIMG = [
'https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg',
'https://d3q6qq2zt8nhwv.cloudfront.net/course/98fc1a05763343bba4807b820c82dbd0.jpg',
'https://seofiles.s3.amazonaws.com/seo/media/ozassignments/images/solution/07e93ffa-410e-4c77-a83d-f0b95f18ab67.png',
'https://cdn-images-1.medium.com/max/1600/1*E4CO83SmCCrvRrge7U3Ahw.jpeg',
    // new todoTemp('https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg', 'Machine Learning'),
    // new todoTemp('https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg', 'Machine Learning'),
    // new todoTemp('https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg', 'Machine Learning'),
  ];

  List<String> tempListTEXT = [
    'Machine Learning',
    'Data Structures', 'Database MS', 'Java'
    // new todoTemp('https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg', 'Machine Learning'),
    // new todoTemp('https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg', 'Machine Learning'),
    // new todoTemp('https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg', 'Machine Learning'),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Personal Space'),
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
                color: Colors.grey,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/addTrainee');
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                color: Colors.blue,
                onPressed: (){
                },
                icon: Icon(Icons.verified_user),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: new TinderSwapCard(
                orientation: AmassOrientation.BOTTOM,
                totalNum: tempListIMG.length,
                stackNum: 3,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.7,
                minHeight: MediaQuery.of(context).size.width * 0.7,
                cardBuilder: (context, index) => todoTemp(tempListIMG[index],tempListTEXT[index])
              ))
      ),
    );
  }
}

class todoTemp extends StatelessWidget{
  String img,text;

  todoTemp(this.img,this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 10.0,
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.25),),
            child: Container(
              height: MediaQuery.of(context).size.width*0.5,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.25),
                image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width*0.05,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      )
    );
  }


}