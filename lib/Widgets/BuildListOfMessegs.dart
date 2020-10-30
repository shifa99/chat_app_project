import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BubbleMessege.dart';

class BuildListOfMessegs extends StatelessWidget {
  final chatName;
  BuildListOfMessegs(this.chatName);
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userid = currentUser.uid;
    final collection = FirebaseFirestore.instance.collection(chatName);
    return StreamBuilder(
      stream: collection.orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, snapShots) =>
          snapShots.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  reverse: true,
                  itemCount: snapShots.data.docs.length,
                  itemBuilder: (ctx, i) => BubbleMessege(
                    messege: snapShots.data.docs[i]['text'],
                    isMe: snapShots.data.docs[i]['userid'] == userid,
                    name: snapShots.data.docs[i]['username'],
                    url: snapShots.data.docs[i]['imageurl'],
                    type: snapShots.data.docs[i]['typeMessege'],
                  ),
                ),
    );
  }
}
