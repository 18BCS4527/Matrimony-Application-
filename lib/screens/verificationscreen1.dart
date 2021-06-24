
import 'package:aabhati/screens/verificationscreen2.dart';
import 'package:flutter/material.dart';
class VerificationScreen1 extends StatefulWidget {
  @override
  _VerificationScreen1State createState() => _VerificationScreen1State();
}

class _VerificationScreen1State extends State<VerificationScreen1> {

  int receive=1;
  int video=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.black87,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 100),
            child: Column(children: <Widget>[
              Text("Voice and Video call",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Aabhaati just launched Voice & Video calling enabling you to talk without revealing your contact details",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
              ),
              SizedBox(height: 20,),
              Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(20),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("VOICE CALL SETTINGS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      Row(
                        children: <Widget>[
                          Radio(hoverColor: Colors.white,activeColor: Colors.white,value: 1, groupValue: receive, onChanged: (val){
                            receive=val;
                            setState(() {

                            });
                          }),
                          Text("Receive all voice calls", textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(hoverColor: Colors.white,activeColor: Colors.white,value: 2, groupValue: receive, onChanged: (val){
                            receive=val;
                            setState(() {

                            });
                          }),
                          Text("Receive only from accepted members", textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Suitable time to receive calls (Specify time in IST)",style: TextStyle(color: Colors.white),),
                      SizedBox(height: 20,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                        Text("05:00 AM",style: TextStyle(color: Colors.white30,fontSize: 15),),
                        SizedBox(width: 50,),
                        Text("04:00 AM",style: TextStyle(color: Colors.white30,fontSize: 15),),
                      ],)

                ],
              )),
              SizedBox(height: 30,),
              Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(20),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("VOICE CALL SETTINGS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      Row(
                        children: <Widget>[
                          Radio(hoverColor: Colors.white,activeColor: Colors.white,value: 1, groupValue: video, onChanged: (val){
                            video=val;
                            setState(() {

                            });
                          }),
                          Text("Receive all voice calls", textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(hoverColor: Colors.white,activeColor: Colors.white,value: 2, groupValue: video, onChanged: (val){
                            video=val;
                            setState(() {

                            });
                          }),
                          Text("Receive only from accepted members", textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
                        ],
                      ),
                    ],
                  )),
          ],),),
          Positioned(top: MediaQuery.of(context).size.height*0.92,
            child: Container(width: MediaQuery.of(context).size.width,height:60,
                child:RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VerificationScreen2()));
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
                      child: const Text('Save',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),),),)
            ),
          ),
        ],
      ),
    ),);
  }
}
