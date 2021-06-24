
import 'package:aabhati/screens/registerotp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  String religion;
  String cast;
  String language;
  int age;
  TextEditingController number=new TextEditingController();
  TextEditingController name=new TextEditingController();
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.black87, width: 1));

  String _phone = "";
  String _countryCode = "+91";
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future _phoneVerify()async{
    CollectionReference reference=Firestore.instance.collection("Users");
    QuerySnapshot querySnapshot=await reference.where('number',isEqualTo: number.text).getDocuments();
    bool have=querySnapshot.documents.isNotEmpty;
    if(have==true){
      _myGlobe.currentState.showSnackBar(SnackBar(
          content: Text('This number was already register!'),
          duration: Duration(seconds: 2)));
    }else{
      verifyPhone();
    }

  }

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
            Map<String, dynamic>user = {
              'religion': religion,
              'cast': cast,
              'language': language,
              'number': number.text,
              'age':age,
              'name':name.text
            };
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) =>
                    RegisterOtp(user, number.text, _verificationId)));
          }
        });
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        setState(() {
          this._verificationId = verId;
          if (_verificationId != null) {
            Map<String, dynamic>user = {
              'religion': religion,
              'cast': cast,
              'language': language,
              'number': number.text,
              'age':age,
              'name':name.text
            };
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) =>
                    RegisterOtp(user, number.text, _verificationId)));
          }
        });
      };
      final PhoneVerificationCompleted verifiedSuccess = (credential) async {
        print(credential);
        print(_verificationId + 'I got result');
        print(credential.providerId + "    --------      AUTO VERIFY");
        setState(() {
          if (_verificationId != null) {
            Map<String, dynamic>user = {
              'religion': religion,
              'cast': cast,
              'language': language,
              'number': number.text,
              'age':age,
              'name':name.text
            };
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) =>
                    RegisterOtp(user, number.text, _verificationId)));
          }
        });
      };
      final PhoneVerificationFailed verificationFailed =
          (AuthException exception) {
        _myGlobe.currentState.showSnackBar(SnackBar(
            content: Text(
                "Something went wrong, check your internet connection or verify phone number again!")));
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
        if (_verificationId != null) {
          Map<String, dynamic>user = {
            'religion': religion,
            'cast': cast,
            'language': language,
            'number': number.text,
            'age':age,
            'name':name.text
          };
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) =>
                  RegisterOtp(user, number.text, _verificationId)));
        }
      });
    }catch(e){
      _myGlobe.currentState.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _myGlobe,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Text("Tell us about you",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text("Religion",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: 65,),
            DropdownButton(
                hint: Text("Your religion         "),
                value: religion,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                onChanged: (newValue) {
                  setState(() {
                    religion = newValue;
                  });
                },
                items: Data().religion.map((f) {
                  return DropdownMenuItem(
                    value: f, child: Text(f.toString().toUpperCase()),);
                }).toList()
            )
          ],),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Cast",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 85,),
              DropdownButton(
                  hint: Text("Your cast               "),
                  value: cast,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (newValue) {
                    setState(() {
                      cast = newValue;
                    });
                  },
                  items: Data().religion.map((f) {
                    return DropdownMenuItem(
                      value: f, child: Text(f.toString().toUpperCase()),);
                  }).toList()
              )
            ],),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Language",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 58,),
              DropdownButton(
                  hint: Text("Your language   "),
                  value: language,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (newValue) {
                    setState(() {
                      language = newValue;
                    });
                  },
                  items: Data().language.map((f) {
                    return DropdownMenuItem(
                      value: f, child: Text(f.toString().toUpperCase()),);
                  }).toList()
              )
            ],),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Your Age",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 58,),
              DropdownButton(
                  hint: Text("Your Age                "),
                  value: age,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (newValue) {
                    setState(() {
                       age= newValue;
                    });
                  },
                  items: Data().age.map((f) {
                    return DropdownMenuItem(
                      value: f, child: Text('$f years'),);
                  }).toList()
              )
            ],),
          SizedBox(height: 10,),
          Container(width: 280,
            child: ListTile(title: Row(
              children: <Widget>[
                Text("Full Name",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text("Name will be displayde",style: TextStyle(color: Colors.grey,fontSize: 12),),
              ],
            ),
              subtitle: TextField(controller: name,
                decoration: InputDecoration(
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    contentPadding: EdgeInsets.only(
                        left: 8, right: 32, top: 4, bottom: 4),
                    hintText: "Your name",
                    hintStyle: TextStyle(color: Colors.black38)),
                onChanged: (value) {
                },
                autofocus: false,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          SizedBox(height: 6,),
          Container(width: 280,
            child: ListTile(title: Row(
              children: <Widget>[
                Text("Phone number",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text("Number will be verified",style: TextStyle(color: Colors.grey,fontSize: 12),),
              ],
            ),
              subtitle: TextField(controller: number,
                decoration: InputDecoration(
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    contentPadding: EdgeInsets.only(
                        left: 8, right: 32, top: 4, bottom: 4),
                    hintText: "Mobile Number",
                    hintStyle: TextStyle(color: Colors.black38)),
                onChanged: (value) {
                },
                autofocus: false,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.phone,
              ),
            ),
          ),
          SizedBox(height: 40,),
          Container(width: 200,
            child: RaisedButton(
              onPressed: () {
                if(number.text.length==10&&name.text.length>4&&religion!=null&&cast!=null&&language!=null){
                  setState(() {
                    _phone=number.text;
                   _phoneVerify();
                  });

                }
                else{
                  _myGlobe.currentState.showSnackBar(SnackBar(
                      content: Text("Please provide above information"),
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
                  constraints: const BoxConstraints(minWidth: 200.0, minHeight: 50.0), // min sizes for Material buttons
                  alignment: Alignment.center,
                  child: const Text('Next',textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                  ),),),),
          ),
      ],),
    );
  }
}



