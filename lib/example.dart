import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
class SampleContent extends StatefulWidget{

  _userState createState() => _userState();

}
class _userState extends State<SampleContent>{

  List<DataHolder> array = [
    new DataHolder('Machine Learning','https://wwwadvectasse.cdn.triggerfish.cloud/uploads/2018/04/machine-learning-e1525867921119-1024x645.jpg'),
    new DataHolder('Data Structures','https://d3q6qq2zt8nhwv.cloudfront.net/course/98fc1a05763343bba4807b820c82dbd0.jpg'),
    new DataHolder('Database MS','https://seofiles.s3.amazonaws.com/seo/media/ozassignments/images/solution/07e93ffa-410e-4c77-a83d-f0b95f18ab67.png'),
    new DataHolder('Java','https://cdn-images-1.medium.com/max/1600/1*E4CO83SmCCrvRrge7U3Ahw.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TinderSwapCard(
          
          swipeCompleteCallback: (CardSwipeOrientation orientation,int index){
             if(orientation==CardSwipeOrientation.RIGHT)
               debugPrint(array[index].title+' swiped right');
             else
               debugPrint(array[index].title+' swiped left');
          },
          swipeUpdateCallback: (DragUpdateDetails details){

          },
          orientation: AmassOrientation.BOTTOM,
          totalNum: array.length,
          stackNum: 3,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.7,
          minHeight: MediaQuery.of(context).size.width * 0.7,
          cardBuilder: (context, index) => createSampleCard(array[index]),
      )
    );
  }

}
class DataHolder{
  String title;
  String img;
  DataHolder(this.title,this.img);
}
class createSampleCard extends StatelessWidget{
  DataHolder obj;

  createSampleCard(this.obj);

  @override
  Widget build(BuildContext context) {
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
                image: DecorationImage(image: NetworkImage(obj.img),fit: BoxFit.cover)
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width*0.05,
          ),
          Text(
            obj.title,
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