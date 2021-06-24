
import 'package:aabhati/screens/verificationscreen4.dart';
import 'package:flutter/material.dart';
class VerificationScreen3 extends StatefulWidget {
  String card;

  VerificationScreen3(this.card);

  @override
  _VerificationScreen3State createState() => _VerificationScreen3State();
}

class _VerificationScreen3State extends State<VerificationScreen3> {
  TextEditingController name=new TextEditingController();
  TextEditingController pan=new TextEditingController();
  bool checkedValue=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.black87,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 6),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              Text("Groom's Name as per ${widget.card} Card",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 30),
              ListTile(title: Text("Full Name",style: TextStyle(color: Colors.white30),),
                subtitle: TextField(style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Name*",
                    hintStyle:TextStyle(color: Colors.white30)
                  ),
                  controller: name,
                ),
                trailing: Icon(Icons.edit,color: Colors.white,),
              ),
              Text("Your profile name will be changed to this name on successful verification",
                textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
              SizedBox(height: 40,),
              Text("Enter Groom's ${widget.card} Number",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              ListTile(title: Text("Enter Number (Without spaces & '-'",style: TextStyle(color: Colors.white30),),
                subtitle: TextField(style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(

                  ),
                  controller: pan,
                ),
              ),
              Text("Your details are 100% secure. Your ID details will not be stored or visible on Aabhaati",
                textAlign: TextAlign.center,style: TextStyle(color: Colors.white30),),
              SizedBox(height: 40,),
              CheckboxListTile(checkColor: Colors.black,activeColor: Colors.white,
                title: Text("I here allow Info Edge (India) Ltd. to provide above details to Aabhaati "
                    "Technologies Pvt to verify ID document from the issuing Authoruty",style: TextStyle(color: Colors.white,fontSize: 13),),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              )

            ],),),
          Positioned(top: MediaQuery.of(context).size.height*0.92,
            child: Container(width: MediaQuery.of(context).size.width,height:60,
                child:RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VerificationScreen4()));
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
                      child: const Text('Verify',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),),),)
            ),
          ),
        ],
      ),
    ),);
  }
}
