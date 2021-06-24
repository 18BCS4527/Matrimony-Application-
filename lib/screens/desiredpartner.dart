
import 'package:aabhati/screens/verificationscreen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data.dart';
class DesiredPartner extends StatefulWidget {
  final bool navigate;
  DesiredPartner(this.navigate);

  @override
  _DesiredPartnerState createState() => _DesiredPartnerState();
}

class _DesiredPartnerState extends State<DesiredPartner> {

  String height;
  String country;
  String marital;
  String religion;
  String caste;
  String motertongue;
  String mangalik;
  String degree;
  String occupation;
  String income;
  String age;
  int cvalue;

  Future _get()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection("Users");
    try{
      reference.document(user.uid).get().then((onValue){
        print(onValue.data);

      });
    }catch(e){
      print(e.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Center(child: Text("Desired Partner",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),),),
      body: Stack(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 2,right: 2,left: 2,bottom: 60),
            child:ListView(scrollDirection: Axis.vertical,physics: ScrollPhysics(),
                children: <Widget>[
                  ListTile(title: Text('Age'),
                    subtitle:age==null?Text("Doesn't Matter"):Text(age),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _age(context, Data().agelimit);
                    },),
                  Divider(),
                  ListTile(title: Text("Height"),
                    subtitle: height==null?Text("Hight limit"):Text(height),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _height(context, Data().hlimit);
                    },),
                  Divider(),
                  ListTile(title: Text("Country"),
                      subtitle:country==null?Text("Doesn't Matter"):Text(country),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _country(context, Data().country);
                  },),
                  Divider(),
                  ListTile(title: Text("Marital Status"),
                      subtitle:marital==null?Text("Doesn't Matter"):Text(marital),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _maritual(context, Data().maritalstatus);
                  },),
                  ListTile(title: Text('Religion'),
                    subtitle:religion==null?Text("Hindu-Jain"):Text(religion),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _religion(context, Data().religion);
                    },),
                  Divider(),
                  ListTile(title: Text("Caste"),
                    subtitle:caste==null?Text("Doesn't Matter"):Text(caste),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _cast(context, Data().caste);
                    },),
                  Divider(),
                  ListTile(title: Text("Mother Tongue"),
                      subtitle:motertongue==null?Text("Hindi-Delhi"):Text(motertongue),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _mothertounge(context, Data().language);
                  },),
                  Divider(),
                  ListTile(title: Text("Mangalik"),
                      subtitle:mangalik==null?Text("Doesn't Matter"):Text(mangalik),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _mangalik(context, Data().manglik);
                  },),
                  Divider(),
                  ListTile(title: Text("Highest Degree"),
                      subtitle:degree==null?Text("BE/B.Tech"):Text(degree),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _degree(context, Data().education);
                  },),
                  Divider(),
                  ListTile(title: Text("Occupation"),
                      subtitle:occupation==null?Text("Doesn't Matter"):Text(occupation),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _occupation(context, Data().occupation);
                  },),
                  Divider(),
                  ListTile(title: Text("Income"),
                      subtitle:income==null?Text("Rs.1 Lakh and above"):Text(income),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _income(context, Data().income);
                  },),
                ])),
        Positioned(top: MediaQuery.of(context).size.height*0.81,
          child: Container(width: MediaQuery.of(context).size.width,height:60,
              child:RaisedButton(
                onPressed: (){
                  if(widget.navigate==false){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VerificationScreen1()));
                  }else{
                    Navigator.pop(context);
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
      ]),
    );
  }
  Widget _maritual(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          marital=h[index];
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
  Widget _mothertounge(BuildContext context,List<String>h){
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
                          motertongue=h[index];
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
  Widget _religion(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          religion=h[index];
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
  Widget _cast(BuildContext context,List<String>h){
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
                          caste=h[index];
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
  Widget _height(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.4,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          height=h[index];
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
  Widget _age(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.4,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          age=h[index];
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
  Widget _mangalik(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.3,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          mangalik=h[index];
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
  Widget _degree(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          degree=h[index];
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
                height: MediaQuery.of(context).size.height*0.5,
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
  Widget _income(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
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
  Widget _country(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.7,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          country=h[index];
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
