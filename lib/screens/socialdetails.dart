
import 'package:aabhati/screens/aboutme.dart';
import 'package:aabhati/screens/profileview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data.dart';

class SocialDetails extends StatefulWidget {
  final bool navigate;
  SocialDetails(this.navigate);

  @override
  _SocialDetailsState createState() => _SocialDetailsState();
}

class _SocialDetailsState extends State<SocialDetails> {

  String marital;
  String motertongue;
  String religion;
  String caste;
  String horoscope;
  String mangalik;
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
        'marital':marital,
        'mothertoung':motertongue,
        'horoscope':horoscope,
        'mangalik':mangalik,
      },merge: true);
      Navigator.pop(context);
      if(widget.navigate==false){
        await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AboutMe()));
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
      title: Center(child: Text("Social Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),),),
      key: _myGlobe,
      body: Stack(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child:Column(
                children: <Widget>[
                  ListTile(title: Text('Marital Status'),
                    subtitle:marital==null?Text("Never Married"):Text(marital),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _maritual(context, Data().maritalstatus);
                    },),
                  Divider(),
                  ListTile(title: Text("Mother Tongue"),
                    subtitle: motertongue==null?Text('Your Mother Tongue'):Text(motertongue),
                    trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                    onTap: (){
                    _mothertounge(context, Data().language);
                    },),
                  Divider(),
                  ListTile(title: Text("Religion-Caste"),
                      subtitle:religion==null?Text("Hindu"):Text(religion),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _religion(context, Data().religion);
                  },),
                  Divider(),
                  ListTile(title: Text("SubCaste"),
                      subtitle:caste==null?Text("Your caste"):Text(caste),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _cast(context, Data().caste);
                  },),
                  Divider(),
                  ListTile(title: Text("Horoscope Must For Marriage?"),
                      subtitle:horoscope==null?Text("Not Necceessary"):Text(horoscope),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _horoscope(context, Data().horoscope);
                  },),
                  Divider(),
                  ListTile(title: Text("Mangalik"),
                      subtitle:mangalik==null?Text("Non Mangalik"):Text(mangalik),
                      trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
                  onTap: (){
                    _mangalik(context, Data().manglik);
                  },)
                ])),
        Positioned(top: MediaQuery.of(context).size.height*0.81,
          child: Container(width: MediaQuery.of(context).size.width,height:60,
              child:RaisedButton(
                onPressed: (){
                  if(marital!=null&&motertongue!=null&&religion!=null&&caste!=null&&horoscope!=null&&mangalik!=null){
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
                    child: const Text('Accept & Continue',textAlign: TextAlign.center,
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
  Widget _horoscope(BuildContext context,List<String>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*0.2,
                child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(title: Text(h[index]),onTap: (){
                        setState(() {
                          horoscope=h[index];
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
}
