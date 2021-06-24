import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Message extends StatefulWidget {
  final String id;
  final String name;
  Message(this.id, this.name);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  String mgs;
  FirebaseUser user;
  TextEditingController message=TextEditingController();
  void _get()async{
    user=await FirebaseAuth.instance.currentUser();
    setState(() {

    });
  }
  Future _chat()async{
    CollectionReference reference=Firestore.instance.collection('Message');
    QuerySnapshot querySnapshot=await reference.document(widget.id).collection('Chat').getDocuments();
    return querySnapshot.documents;
  }
  @override
  void initState() {
    // TODO: implement initState
    _get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,centerTitle: true,title: Column(children: <Widget>[
      Text('${widget.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
      Text('Today at 5:00 PM',style: TextStyle(fontSize: 10,color: Colors.black),)
    ],),
    leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: (){
      Navigator.pop(context);
    }),),
      body: FutureBuilder(
        future: _chat(),
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[ 
              Expanded(flex: 9,
                child: Container(width: MediaQuery.of(context).size.height,height: MediaQuery.of(context).size.height,
                  child: ListView.builder(itemCount: snapshot.data.length,shrinkWrap: true,physics: BouncingScrollPhysics(),itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Container(width: MediaQuery.of(context).size.width,alignment:snapshot.data[index].data['sender']==user.uid?Alignment.centerRight:Alignment.centerLeft,
                          child: Container(width: MediaQuery.of(context).size.width*0.6,child: Row(
                            children: <Widget>[
                              Expanded(flex: 8,child: Text('${snapshot.data[index].data['mgs']}',style: TextStyle(color: Colors.white,fontSize: 16),)),
                              Expanded(flex: 2,child: Text('${DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot.data[index].data['time'].toString())))}',
                              style: TextStyle(fontSize: 12,color: Colors.white70),textAlign: TextAlign.end,))
                            ],
                          ),
                            padding: EdgeInsets.all(8),
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.orange],),
                            ),),
                          padding: EdgeInsets.all(4),
                        ),
                        SizedBox(height: 10)
                      ],
                    );
                  },)
                ),
              ),
              Expanded(flex: 1,child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                      width: 1,
                    )),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 25),
                    Expanded(flex: 7,
                      child: Container(
                        child: TextField(controller: message,
                          onChanged: (text) {
                            setState(() {
                              mgs=text;
                            });
                          },
                          decoration: InputDecoration(contentPadding: EdgeInsets.all(4),
                            hintText: "Type a message",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(width: 1,)
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(child: GestureDetector(child: Text('Send'),
                    onTap: (){
                      if(mgs.length>0&&user!=null){
                        setState(() {
                          message.text='';
                        });
                        _upload();
                      }
                    },))
                  ],
                ),
              ),)
            ],
          );
        }
      ),
    );
  }
  Future _upload()async{
    var data={
      'mgs':mgs,
      'sender':user.uid,
      'time':DateTime.now().millisecondsSinceEpoch.toString()
    };
    CollectionReference reference=Firestore.instance.collection('Message');
    try{
      reference.document(widget.id).collection('Chat').document(data['time']).setData(data);
    }catch(e){
      print(e);
    }

  }
}
