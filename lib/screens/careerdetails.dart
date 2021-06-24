
import 'package:aabhati/screens/profileview.dart';
import 'package:aabhati/screens/socialdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data.dart';
class CarrerDetails extends StatefulWidget {
  final bool navigate;
  CarrerDetails(this.navigate);
  @override
  _CarrerDetailsState createState() => _CarrerDetailsState();
}

class _CarrerDetailsState extends State<CarrerDetails> {

  String edu;
  String employ;
  String occupation;
  dynamic income;
  int cvalue;
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();

  Future _upload()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.orange,),
      );
    }, barrierDismissible: false);
    CollectionReference reference=Firestore.instance.collection("Users");
    try{
      await reference.document(user.uid).setData({
        'education':edu,
        'employ':employ,
        'occupation':occupation,
        'income':income
      },merge: true);
      Navigator.pop(context);
      if(widget.navigate==false){
        await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SocialDetails(false)));
      }else{
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ProfileView()));
      }

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
      title: Center(child: Text("Career Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),),),
      key: _myGlobe,
      body: Stack(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child:Column(
                children: <Widget>[
                  ListTile(title: Text('Highest Qualification'),
                    subtitle:edu==null?Text('Your degree'):Text('$edu lac'),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _education(context, Data().education);
                    },),
                  Divider(),
                  ListTile(title: Text("Employed In"),
                    subtitle: employ==null?Text("Your employed in"):Text(employ),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _employ(context, Data().employ);
                    },),
                  Divider(),
                  ListTile(title: Text("Occupation"),
                      subtitle:occupation==null?Text("Your occupation"):Text(occupation),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _occupation(context, Data().occupation);
                  },),
                  Divider(),
                  ListTile(title: Text("Annual Income"),
                      subtitle:income==null?Text("Choose your income"):Text('$income lac'),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _income(context, Data().income);
                    },)
                ])),
        Positioned(top: MediaQuery.of(context).size.height*0.81,
          child: Container(width: MediaQuery.of(context).size.width,height:60,
              child:RaisedButton(
                onPressed: (){
                  if(edu!=null&&employ!=null&&occupation!=null&&income!=null){
                    setState(() {
                      _upload();
                    });

                  }else{
                    _myGlobe.currentState.showSnackBar(SnackBar(
                        content: Text("Please provide above information"),
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
                    child: const Text('Continue',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),),),)
          ),
        ),
      ]),
    );
  }
  Widget _education(BuildContext context,List<dynamic>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
            width: double.maxFinite,
            child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
              return Column(
                children: <Widget>[
                  ListTile(title: Text('${h[index]}'),onTap: (){
                    setState(() {
                      edu=h[index];
                      Navigator.pop(context);
                    });
                  },
                    trailing:Radio(value: index, groupValue:cvalue, onChanged: (val){
                      setState(() {
                        cvalue=val;
                      });
                    }),),
                  Divider()
                ],
              );
            })
        ),
      );
    });
  }
  Widget _employ(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          employ=h[index];
                          Navigator.pop(context);
                        });
                      },
                        trailing:Radio(value: cvalue, groupValue:index, onChanged: (val){
                          setState(() {
                            cvalue=val;
                          });
                        }),),
                      Divider()
                    ],
                  );
                })
            ),
          );
        });
  }
  Widget _occupation(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          occupation=h[index];
                          Navigator.pop(context);
                        });
                      },
                        trailing:Radio(value: cvalue, groupValue:index, onChanged: (val){
                          setState(() {
                            cvalue=val;
                          });
                        }),),
                      Divider()
                    ],
                  );
                })
            ),
          );
        });
  }
  Widget _income(BuildContext context,List<dynamic>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text('${h[index]} lac'),onTap: (){
                        setState(() {
                          income=h[index];
                          Navigator.pop(context);
                        });
                      },
                        trailing:Radio(value: cvalue, groupValue:index, onChanged: (val){
                          setState(() {
                            cvalue=val;
                          });
                        }),),
                      Divider()
                    ],
                  );
                })
            ),
          );
        });
  }
}
