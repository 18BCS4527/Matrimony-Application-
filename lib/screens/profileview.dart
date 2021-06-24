import 'package:aabhati/screens/personaldetails.dart';
import 'package:aabhati/screens/socialdetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'careerdetails.dart';
class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView> {

  String profile='';
  String number='';
  String religion='';
  String cast='';
  String gender='';
  String dob='';
  String height='';
  String country='';
  String education='';
  String occupation='';
  String income='';
  String employ='';
  String mangalik='';
  String maritual='';
  String hroscope='';
  Future _get()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection("Users");
    try{
      reference.document(user.uid).get().then((onValue){
        setState(() {
          profile=onValue.data['profile'];
          number=onValue.data['number'];
          religion=onValue.data['religion'];
          cast=onValue.data['cast'];
          gender=onValue.data['gender'];
          dob=onValue.data['dob'];
          occupation=onValue.data['occupation'];
          height='${onValue.data['height']} feet';
          country=onValue.data['country'];
          education=onValue.data['education'];
          income='${onValue.data['income']} lac';
          employ=onValue.data['employ'];
          mangalik=onValue.data['mangalik'];
          maritual=onValue.data['marital'];
          hroscope=onValue.data['horoscope'];
        });
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
    return Scaffold(
      appBar: AppBar(title: Text("Profile",style: TextStyle(color: Colors.black),),leading: Icon(Icons.arrow_back_ios,color: Colors.black),
        backgroundColor: Colors.white,
      actions: <Widget>[
        profile!=null?ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CachedNetworkImage(
            imageUrl: profile, width: 55, height:55, fit: BoxFit.cover,
          ),
        ):CircleAvatar(
          radius: 20, backgroundColor: Colors.white,
          child: Icon(Icons.person),
        ),
      ],),
      body: FutureBuilder(
          future: _get(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(elevation: 2,child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(children: <Widget>[
                      ListTile(title: Text("Personal",style: TextStyle(fontWeight: FontWeight.bold),),leading: Icon(Icons.person),trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PersonalDetails(true)));
                      }),),
                      Divider(),
                      _buildExperienceRow(company: "Gender", position: gender,),
                      _buildExperienceRow(company: "Phone No", position: number,),
                      _buildExperienceRow(company: "Country", position: country,),
                      _buildExperienceRow(company: "Date of Birth", position: dob,),
                      _buildExperienceRow(company: "Height", position: height,),
                    ],),
                  ),),
                  Card(elevation: 2,child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(children: <Widget>[
                      ListTile(title: Text("Carrer",style: TextStyle(fontWeight: FontWeight.bold),),leading: Icon(Icons.work),trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>CarrerDetails(true)));
                      }),),
                      Divider(),
                      _buildExperienceRow(company: "Highest Qualification", position: education,),
                      _buildExperienceRow(company: "Employed In", position: employ,),
                      _buildExperienceRow(company: "Occupation", position: occupation,),
                      _buildExperienceRow(company: "Annual Income", position: income,),
                    ],),
                  ),),
                  Card(elevation: 2,child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(children: <Widget>[
                      ListTile(title: Text("Social",style: TextStyle(fontWeight: FontWeight.bold),),leading: Icon(Icons.group),trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SocialDetails(true)));
                      }),),
                      Divider(),
                      _buildExperienceRow(company: "Religion", position: religion,),
                      _buildExperienceRow(company: "Caste", position: cast,),
                      _buildExperienceRow(company: "Maritual", position: maritual,),
                      _buildExperienceRow(company: "Mangalik", position: mangalik,),
                      _buildExperienceRow(company: "Horoscope", position:hroscope,),
                    ],),
                  ),),
                  SizedBox(height: 20.0),
                ],
              ),
            );
          }
      ),
    );
  }
  ListTile _buildExperienceRow({String company, String position,Icon icon}) {
    return ListTile(
      title: Text(company, style: TextStyle(
        color: Colors.black,
      ),),
      subtitle: position!=null?Text("$position"):Text("Not filled",style: TextStyle(color: Colors.red),),
      contentPadding: EdgeInsets.only(left: 10,bottom: 0,top: 0),
    );
  }

}
