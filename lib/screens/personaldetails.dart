
import 'package:aabhati/screens/profileview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data.dart';
import 'careerdetails.dart';
class PersonalDetails extends StatefulWidget {
final bool navigate;
PersonalDetails(this.navigate);

@override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  String gender='male';
  String dob;
  double height;
  String country;
  List<double>h=Data().height;
  List<String>c=Data().country;
  int hvalue;
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
        'gender':gender,
        'dob':dob,
        'height':height,
        'country':country
      },merge: true);
      Navigator.pop(context);
      if(widget.navigate==false){
        await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CarrerDetails(false)));
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
      title: Center(child: Text("Personal Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),),),
      key: _myGlobe,
      body: Stack(children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(top: 30),
         child:Column(
           children: <Widget>[ Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              gender=='male'?RaisedButton(
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
                    child: const Text('Male',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),),),):RaisedButton(
                onPressed: () {
                  gender='male';
                  setState(() {
                  });
                },
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text('Male',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,fontSize: 18,),
                    ),),),),

              gender=='female'?RaisedButton(
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
                    child: const Text('Female',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),),),):RaisedButton(
                onPressed: () {
                  gender='female';
                  setState(() {

                  });
                },
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 150.0, minHeight: 50.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text('Female',textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,fontSize:18),
                    ),),),),
            ],),
             SizedBox(height: 20,),
             ListTile(title: Text('Date of Birth'),
              subtitle: dob==null?Text("Choose your date of birth"):Text(dob),
              trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
             onTap: (){
             showDatePicker(context:context, initialDate: DateTime.now(),
                  firstDate:DateTime(1950), lastDate:DateTime.now()).then((onValue){
                    print(onValue);
                    setState(() {
                      dob=DateFormat.yMMMd('en_US').format(onValue);
                    });
                  });
             },),
             Divider(),
             ListTile(title: Text("Height"),
                 subtitle: height==null?Text('Choose your height'):Text('$height'),
                 trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
             onTap: (){
               _listPopup(context,h);
             },),
             Divider(),
             ListTile(title: Text("Livinng in"),
               subtitle:country==null?Text('Choose your height'):Text(country),
               trailing: Icon(Icons.navigate_next,size: 45,color: Colors.black),
             onTap: (){
               _country(context, c);
             },)
         ])),
        Positioned(top: MediaQuery.of(context).size.height*0.81,
          child: Container(width: MediaQuery.of(context).size.width,height:60,
              child:RaisedButton(
                onPressed: () {
                  if(dob!=null&&height!=null&&country!=null){
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
      ],),
    );
  }
  Widget _listPopup(BuildContext context,List<double>h){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(itemCount: h.length,itemBuilder: (BuildContext context,int index){
                return Column(
                  children: <Widget>[
                    ListTile(title: Text('${h[index]} feet'),onTap: (){
                      setState(() {
                        height=h[index];
                        Navigator.pop(context);
                      });
                    },
                      trailing:Radio(value: index, groupValue: hvalue, onChanged: (val){
                        setState(() {
                          hvalue=val;
                        });
                      }),),
                    Divider()
                  ],
                );
              })
            ),
          );
        }
    );
  }
  Widget _country(BuildContext context,List<String>h){
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
                          country=h[index];
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
        }
    );
  }
}
