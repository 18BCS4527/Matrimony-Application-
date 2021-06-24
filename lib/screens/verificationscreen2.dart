
import 'package:aabhati/screens/verificationscreen3.dart';
import 'package:flutter/material.dart';
class VerificationScreen2 extends StatefulWidget {
  @override
  _VerificationScreen2State createState() => _VerificationScreen2State();
}

class _VerificationScreen2State extends State<VerificationScreen2> {

  int card;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.black87,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 6),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              Text("Become a Verified Member",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("We are moving towards a more secure platform by verifying our user's basic details",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
              ),
              SizedBox(height: 20,),
              Container(width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 30,backgroundColor: Colors.transparent,
                  child: Image.asset('assets/shield.png'),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 40,left: 40),
                child: Text("100% secure. Your ID details will not be stored or visible on Aabhaati",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
              ),
              SizedBox(height: 40,),
              Text("I want to verify using:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(hoverColor: Colors.white,activeColor: Colors.white,value: 1, groupValue: card, onChanged: (val){
                    card=val;
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VerificationScreen3('Aadhar')));
                    setState(() {

                    });
                  }),
                  Text("Aadhar Card", textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(hoverColor: Colors.white,activeColor: Colors.white,value: 2, groupValue: card, onChanged: (val){
                    card=val;
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VerificationScreen3('Pan')));
                    setState(() {

                    });
                  }),
                  Text("Pan Card   ", textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ],
              ),

            ],),),
        ],
      ),
    ),);
  }
}
