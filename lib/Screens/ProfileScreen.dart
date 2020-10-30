import 'dart:io';

import 'package:chat_app/Services/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = 'profileScreen';
  final userid;
  ProfileScreen({this.userid});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _form = GlobalKey<FormState>();
  String username;
  File _image;
  bool update_username = false;
  bool update_background = false;
  var userData;
  Future<DocumentSnapshot> readUserData() async {
    userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .get();
    return userData;
  }

  void saved() async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    if (username != null) update_username = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .update({
      'username': update_username ? username : userData['username'],
    });
    final data = await FirebaseFirestore.instance
        .collection('newchats')
        .where('userid', isEqualTo: widget.userid)
        .get();
    data.docs.forEach((element) async {
      await FirebaseFirestore.instance.doc('newchats/${element.id}').update({
        'username': update_username ? username : userData['username'],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    readUserData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff333456),
        title: Text(
          'Profile',
          style: KStyle.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: FutureBuilder(
            future: readUserData(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  )
                : Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(snapshot.data['image']),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Form(
                          key: _form,
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            initialValue: snapshot.data['username'],
                            validator: (username) {
                              if (username.isEmpty)
                                return 'Please Enter userName';
                              return null;
                            },
                            onChanged: (newusername) {
                              username = newusername;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Color(0xff060930),
                          child: Text(
                            'Update',
                            style: KStyle.copyWith(color: Colors.white),
                          ),
                          onPressed: () {
                            print(username);
                            saved();
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
