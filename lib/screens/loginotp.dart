import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'home.dart';

class LoginOtp extends StatefulWidget {

  final String id;
  final String phone;
  LoginOtp(this.id,this.phone);

  @override
  _LoginOtpState createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  String verifiid;
  String _smsCode;
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    verifiid=widget.id;
    print(verifiid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _myGlobe,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
        Text("Verification Code",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        Padding(
          padding: const EdgeInsets.only(top: 40,left: 30,right: 30,bottom: 20),
          child: Text("OTP has been sent to your mobile number please verify",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: PinInputTextField(
            pinLength: 6,
            onChanged: (val){
            this._smsCode=val;
            },
            decoration: BoxTightDecoration(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,),solidColor: Colors.white, strokeColor: Colors.black, radius: Radius.circular(12),),
            autoFocus: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30,left: 30,right: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("If you didn't receive a code!",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
              SizedBox(width: 10,),
              Text("Resend",textAlign: TextAlign.center,style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 18),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: RaisedButton(
            onPressed: () {
            if(_smsCode.length==6){
              signIn();
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
                child: const Text('Verify',textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                ),),),),
        )

      ],),
    );
  }
  void signIn() async {
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.orange,),
      );
    }, barrierDismissible: false);
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verifiid, smsCode: _smsCode);
    _signInWithCredential(credential);
    print(credential.providerId + "   ------    SIGNIN");
  }
  _signInWithCredential(AuthCredential credential) async {
    FirebaseUser user;
    try {
      final authRes = await _auth.signInWithCredential(credential);
      user = authRes.user;
    } catch (err) {
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text("You have entered wrong OTP"),
          duration: Duration(seconds: 2)));
    }

    if (user != null) {
       Navigator.pop(context);
      await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
    } else {
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text("Please try again!"), duration: Duration(seconds: 2)));
    }
  }

  String _countryCode = "+91";

  Future<void> verifyPhone() async {

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verifiid = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      showDialog(context: context,builder: (context) {
        return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.orange,),
        );
      }, barrierDismissible: false);
      setState(() {
        this.verifiid = verId;
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (credential) async {
      print(credential);
      print(credential.providerId + "    --------      AUTO VERIFY");
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text(
              "Something went wrong, check your internet connection or verify phone number again!")));
      print('${exception.message}');
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: this._countryCode + widget.phone,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 120),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verificationFailed,
    );
    setState(() {

    });
    await Navigator.pop(context);
  }
}
