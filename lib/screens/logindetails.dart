
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'aboutme.dart';
class LoginDetails extends StatefulWidget {

  @override
  _LoginDetailsState createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  TextEditingController name=new TextEditingController();
  TextEditingController number=new TextEditingController();
  TextEditingController mail=new TextEditingController();
  TextEditingController password=new TextEditingController();
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();


  Future _signUp()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    FirebaseUser user;
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.orange,),
      );
    }, barrierDismissible: false);
    await auth.createUserWithEmailAndPassword(email: mail.text, password: password.text).then((onValue){
      user=onValue.user;
      print(user.uid);
    }).catchError((onError){
      Navigator.pop(context);
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text(onError),
          duration: Duration(seconds: 2)));
    }).whenComplete((){
  _upload(user);
    });
  }
  Future _upload(FirebaseUser user)async{
    CollectionReference reference=Firestore.instance.collection("Users");
    try {
//      reference.document(user.uid).setData({
//        'name': name.text,
//        'number': number.text,
//        'user': widget.userform,
//        'personal': widget.personal,
//        'career': widget.career,
//        'socail': widget.social,
//      });
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AboutMe()));
    }catch(e){
      Navigator.pop(context);
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text(e),
          duration: Duration(seconds: 2)));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Center(child: Text("Login Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),),),
      key: _myGlobe,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView(children: <Widget>[
              ListTile(title: Text("Full Name"),
                subtitle: TextField(
                  decoration: InputDecoration(
                      hintText: "Name *",
                      border: InputBorder.none
                  ),
                  controller: name,
                ),
              ),
              Divider(),
              ListTile(title: Row(children: <Widget>[Text("Phone Number"),Text("(This number will be verified)",style: TextStyle(color: Colors.grey,fontSize: 13),)],),
                subtitle: TextField(
                  decoration: InputDecoration(
                      hintText: "Number*",
                      border: InputBorder.none
                  ),
                  controller: number,
                ),
              ),
              Divider(),
              ListTile(title: Text("Email ID"),
                subtitle: TextField(
                  decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      border: InputBorder.none
                  ),
                  controller: mail,
                ),
              ),
              Divider(),
              ListTile(title: Text("Create New Password"),
                subtitle: TextField(
                  decoration: InputDecoration(
                      hintText: "**********",
                      border: InputBorder.none
                  ),
                  controller: password,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Use 8 or more characters with a mix of letters(a-z) & numbers(0-9)",style: TextStyle(fontSize: 10,color: Colors.grey),),
              ),
              Divider(),
            ],),
          ),
          Positioned(top: MediaQuery.of(context).size.height*0.78,
            child: Container(width: MediaQuery.of(context).size.width,
                child:Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
                  Text("Terms of Use",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                  SizedBox(width:40,),
                  Text("Privacy Policy",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                ],)),
          ),
          Positioned(top: MediaQuery.of(context).size.height*0.81,
            child: Container(width: MediaQuery.of(context).size.width,height:60,
                child:RaisedButton(
                  onPressed: (){
                    if(name.text.length>4&&number.text.length>9&&mail.text.length>10&&password.text.length>8){
                      _signUp();
                    }else{
                      _myGlobe.currentState.showSnackBar(SnackBar(
                          content: Text("Please provide vaild details"),
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
                      child: const Text('Accept & Continue',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),),),)
            ),
          ),
        ],
      ),);
  }
}
