
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'desiredpartner.dart';
class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  TextEditingController about=new TextEditingController();
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();

  Future _upload() async{
    FirebaseAuth auth=FirebaseAuth.instance;
    FirebaseUser user=await auth.currentUser();
    CollectionReference reference=Firestore.instance.collection("Users");
    try{
      reference.document(user.uid).setData({'about':about.text
      },merge: true).whenComplete((){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DesiredPartner(false)));
      });
    }catch(e){
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text(e),
          duration: Duration(seconds: 2)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Center(child: Text("About Me",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)))),
      key: _myGlobe,
      body: Stack(children: <Widget>[
        Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Introduce yourself in a minimum of 25 words (Don't mention your name or number)."
                      "You can write about your values/beliefs,aspiration,intrests and hobbies.",
                  border: InputBorder.none
              ),
              minLines: 8,
              maxLines: 10,
              controller: about,
            ),
          ),
        ],),
        Positioned(top: MediaQuery.of(context).size.height*0.81,
          child: Container(width: MediaQuery.of(context).size.width,height:60,
              child:RaisedButton(
                onPressed: (){
                  if(about.text.length>10){
                    _upload();
                  }else{
                    _myGlobe.currentState.showSnackBar(SnackBar(
                        content: Text("Tell us about you at least 100 words"),
                        duration: Duration(seconds: 2)));
                  }

                },
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.orange],),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text('Next',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),),),)
          ),
        ),
      ],),
    );
  }
}
