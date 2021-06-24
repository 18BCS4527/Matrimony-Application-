import 'package:aabhati/screens/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Acceptance extends StatefulWidget {
  @override
  _AcceptanceState createState() => _AcceptanceState();
}

class _AcceptanceState extends State<Acceptance> {

  static List<User>p=[];
  List<User>users=[];
  bool accept=false;
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();

  void _get() async{
    FirebaseUser _user=await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection("Users");
    CollectionReference collectionReference=Firestore.instance.collection('Requests');

    if(accept){
      p.clear();
      users.clear();
      try{
        QuerySnapshot querySnapshot=await reference.getDocuments();
        QuerySnapshot snapshot=await collectionReference.where('from',isEqualTo: _user.uid).getDocuments();
        querySnapshot.documents.map((f){
          if(snapshot.documents.length>0){
            snapshot.documents.map((value){
              if(f.data['uid']==value.data['to']){
                setState(() {
                  p.add(User(f.data['name'], '${f.data['age'].toString()} years', f.data['religion'], f.data['country'], value.data['status'],f.data['profile'],f.data['uid'],value.data['id']));
                  users=List.from(p);
                });
              }
            }).toList();
          }
        }).toList();
      }catch(e){
        print(e.toString());
      }
    }
    else{
      p.clear();
      users.clear();
      try{
        QuerySnapshot querySnapshot=await reference.getDocuments();
        QuerySnapshot snapshot=await collectionReference.where('to',isEqualTo: _user.uid).getDocuments();
        querySnapshot.documents.map((f){
          if(snapshot.documents.length>0){
            snapshot.documents.map((value){
              if(f.data['uid']==value.data['from']){
                setState(() {
                  p.add(User(f.data['name'], '${f.data['age'].toString()} years', f.data['religion'], f.data['country'], value.data['status'],f.data['profile'],f.data['uid'],value.data['id']));
                  users=List.from(p);
                });
              }
            }).toList();
          }
        }).toList();
      }catch(e){
        print(e.toString());
      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    _get();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    p.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _myGlobe,
      body: FutureBuilder(
          builder: (context, snapshot) {
            return Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.075,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                        Expanded(flex: 1,child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                          Navigator.pop(context);
                        })),
                        Expanded(flex: 9,child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                            accept?RaisedButton(
                              onPressed: null,
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.red, Colors.orange],),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text('Accepted Me',textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),),),):RaisedButton(
                              onPressed: () {
                                _get();
                                setState(() {
                                  accept=true;
                                });
                              },
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text('Accepted Me',textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,fontSize: 18,),
                                  ),),),),

                            !accept?RaisedButton(
                              onPressed: null,
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.red, Colors.orange],),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text('I Accepted',textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),),),):RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft:Radius.circular(5) )),
                              onPressed: () {
                                _get();
                                setState(() {
                                  accept=false;
                                });
                              },
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text('I Accepted',textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,fontSize:18),
                                  ),),),),
                          ],),
                        ),
                        )
                      ],),
                    ),
                    users.length>0? Container(height: MediaQuery.of(context).size.height*0.895,width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(bottom: 4),
                        child: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,children: users.map((f){
                          return  Container(height: MediaQuery.of(context).size.height*0.895,width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 8),
                            child: Stack(children: <Widget>[
                              Image.network(
                                f.profile,
                                width:  MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.82,
                                fit: BoxFit.cover,
                                frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded || frame != null) {
                                    return Container(
                                      child:child,
                                      foregroundDecoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [Colors.transparent,Colors.black87]
                                          )
                                      ),
                                      height: MediaQuery.of(context).size.height*0.82,
                                      width: MediaQuery.of(context).size.width,
                                    );
                                  } else {
                                    return Container(
                                      child: CircularProgressIndicator(
                                          value: null,
                                          backgroundColor: Colors.white),
                                      alignment: Alignment(0, 0),
                                      constraints: BoxConstraints.expand(),
                                    );
                                  }
                                },
                              ),
                              Positioned(top: MediaQuery.of(context).size.height*0.65,
                                child: Container(width: MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height*0.19,
                                    padding: EdgeInsets.only(left: 10),
                                    child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                                      Text('${f.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white70),),
                                      Text('${f.age} ',style: TextStyle(fontSize: 18,color: Colors.white70)),
                                      Text('${f.religion}',style: TextStyle(fontSize: 18,color: Colors.white70)),
                                      Text('${f.country}',style: TextStyle(fontSize: 18,color: Colors.white70)),
                                    ],)
                                ),
                              ),
                              Positioned(top: MediaQuery.of(context).size.height*0.81,
                                child: Container(width: MediaQuery.of(context).size.width,height:60,
                                    child:RaisedButton(
                                      onPressed: (){
                                        if(f.status=='REQUESTED'&&!accept){
                                         _upload(f.id);
                                        }
                                        if(f.status=='ACCEPTED'){
                                          print(f.status);
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Message(f.id, f.name)));
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
                                          child: f.status=='REQUESTED'&&accept?Text('Your REQUESTED',textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white,fontSize: 18),
                                          ):f.status=='REQUESTED'&&!accept?Text('Accept Now',textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white,fontSize: 18),
                                          ):f.status=='ACCEPT'&&accept?Text('Write Message',textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white,fontSize: 18),
                                          ):Text('Write Message',textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white,fontSize: 18),
                                          ),),),)
                                ),
                              ),

                            ],),);
                        }).toList(),)
                    ):Container(height: MediaQuery.of(context).size.height*0.895,width: MediaQuery.of(context).size.width,
                      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                        Icon(Icons.group),
                        Text('No such data found')
                      ],),),
                    ),
                  ],
                )
            );
          }
      ),
    );
  }
  Future _upload(String id)async{
    FirebaseUser user= await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection('Requests');
    try{
      reference.document(id).setData({'status':'ACCEPTED'},merge: true);
      setState(() {
        p.clear();
        users.clear();
        _get();
      });
      _myGlobe.currentState.showSnackBar(SnackBar(content: Text('You can message now')));
    }catch(e){
      _myGlobe.currentState.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class User{
  String name;
  String age;
  String religion;
  String country;
  String status;
  String profile;
  String uid;
  String id;
  User(this.name, this.age, this.religion, this.country, this.status,this.profile,this.uid,this.id);
}