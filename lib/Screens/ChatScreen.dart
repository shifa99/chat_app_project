import 'package:chat_app/Services/Constants.dart';
import 'package:chat_app/Widgets/BubbleMessege.dart';
import 'package:chat_app/Widgets/BuildAppBar.dart';
import 'package:chat_app/Widgets/BuildListOfMessegs.dart';
import 'package:chat_app/Widgets/SendMessege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = 'chatScreen';
  final userid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    // final userid = FirebaseAuth.instance.currentUser.uid;
    // final
    // final currentUser = FirebaseAuth.instance.currentUser;
    // final userid = currentUser.uid;
    // final collection = FirebaseFirestore.instance.collection('newchats');
    return Scaffold(
        appBar: buildAppBar(context, userid),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BuildListOfMessegs('newchats'),
            ),
            SendMessege(userid),
          ],
        ));
  }
}
