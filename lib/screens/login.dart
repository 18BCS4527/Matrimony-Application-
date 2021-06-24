
import 'package:aabhati/screens/home.dart';
import 'package:aabhati/screens/loginotp.dart';
import 'package:aabhati/screens/userform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController number=new TextEditingController();
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.white, width: 1));

  Future _user()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    FirebaseUser user=await auth.currentUser();
    if(user!=null){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
    }
    
  }
  Future _phoneVerify()async{
    CollectionReference reference=Firestore.instance.collection("Users");
    QuerySnapshot querySnapshot=await reference.where('number',isEqualTo: number.text).getDocuments();
    bool have=querySnapshot.documents.isNotEmpty;
    if(have==true){
      verifyPhone();
    }else{
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text('Your not a existing user with us'),
          duration: Duration(seconds: 2)));
    }
    
  }
  String _phone = "";
  String _countryCode = "+91";
  String _smsCode = "";
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.orange,),
      );
    }, barrierDismissible: false);
    try {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        setState(() {
          this._verificationId = verId;
          if (_verificationId != null) {
            print(_verificationId+'...................Autoretrieve');
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoginOtp(_verificationId, _phone)));
          }
        });
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        setState(() {
          this._verificationId = verId;
          if (_verificationId != null) {
            print(_verificationId+'...............Sms sent');
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoginOtp(_verificationId, _phone)));
          }
        });
      };
      final PhoneVerificationCompleted verifiedSuccess = (credential) async {
        print(_verificationId+'.......................I got result');
        setState(() {
          if (_verificationId != null) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoginOtp(_verificationId, _phone)));
          }
        });
        _myGlobe.currentState.showSnackBar(SnackBar(
            content: Text("Verify yoour number")));
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException exception) {
            Navigator.pop(context);
        _myGlobe.currentState.showSnackBar(SnackBar(
            content: Text(
                exception.message)));
        print('${exception.message}');
      };

      await _auth.verifyPhoneNumber(
        phoneNumber: this._countryCode + this._phone,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
      ).whenComplete(() {
        setState(() {
          if (_verificationId != null) {
            print(_verificationId+'Autoretrieve');
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoginOtp(_verificationId, _phone)));
          }
        });
      });
    }catch(e){
      Navigator.pop(context);
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text(e.toString())));

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    _user();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _myGlobe,
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(top: MediaQuery.of(context).size.height*0.1,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 30,backgroundColor: Colors.white,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("AABHAATI AR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                ],
              ),
            ),
            Center(child: Container(width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.height*0.40,
              decoration: BoxDecoration(color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 45.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 10  horizontally
                        2.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: ListView(children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 20,top: 40),
                  child: Text("Phone Number",style: TextStyle(fontWeight: FontWeight.bold),),),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 4),
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        TextField(controller: number,
                          decoration: InputDecoration(
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                              contentPadding: EdgeInsets.only(
                                  left: 8, right: 32, top: 4, bottom: 4),
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(color: Colors.black38)),
                          onChanged: (value) {
                          setState(() {
                            _phone=value;
                          });

                          },
                          style: TextStyle(color: Colors.black),

                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:
                        Border.all(width: 1, color: Colors.grey.shade400)),
                  ),
                ),
                SizedBox(height: 36,),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: RaisedButton(
                    onPressed: () {
                      if(number.text.length==10){
                        number.text=_phone;
                        setState(() {
//                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LoginOtp()));
                          _phoneVerify();
                        });

                      }else{
                        _myGlobe.currentState.showSnackBar(SnackBar(
                            content: Text("Please provide a valid phone number"),
                            duration: Duration(seconds: 2)));
                      }
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange],),
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 40.0, minHeight: 50.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text('LogIn',textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                        ),),),),
                )
              ],),
            ),
            ),
            Positioned(top: MediaQuery.of(context).size.height*0.82,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,
              child: Column(
                children: <Widget>[
                  Text("Not registerd yet?"),
                  SizedBox(height: 6,),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>UserForm()));
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange],),
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 200.0, minHeight: 50.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text('Register',textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                        ),),),),
                ]),
            ),
          ],),
      ),);
  }

}
