
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
class VerificationScreen4 extends StatefulWidget {
  @override
  _VerificationScreen4State createState() => _VerificationScreen4State();
}

class _VerificationScreen4State extends State<VerificationScreen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.black87,child: Stack(children: <Widget>[
      Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
        Text("Verification Successful",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        SizedBox(height: 30,),
        Container(width: 80,
          height: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle),
          child: CircleAvatar(
            radius: 30,backgroundColor: Colors.transparent,
            child: Image.asset('assets/shield.png'),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Thank you for verifying details. A verification shield will now be shown against your profile"
              "depicting that your Govt. ID has been verified against your name",
            style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("It may take up to 2 minutes for the shield to be added on your profile"
            ,style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
        )
      ],),
      Positioned(top: MediaQuery.of(context).size.height*0.92,
        child: Container(width: MediaQuery.of(context).size.width,height:60,
            child:RaisedButton(
              onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
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
                  child: const Text('OK',textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 18),
                  ),),),)
        ),
      ),
    ],),),);
  }
}
