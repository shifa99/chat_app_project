import 'package:chat_app/Services/Constants.dart';
import 'package:chat_app/Widgets/BuildAppBar.dart';
import 'package:chat_app/Widgets/BuildListOfMessegs.dart';
import 'package:chat_app/Widgets/SendMessege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatWithFriend extends StatelessWidget {
  static String routeName = 'ChatWithFriend';
  var chatid;
  var friendData;
  var friendName;
  var friendImage;
  Future<void> getChatID(String userid, String friendid) async {
    chatid = userid + friendid;
    final reverseChatid = friendid + userid;
    final check1 = await FirebaseFirestore.instance
        .collection(chatid)
        .where('userid', isEqualTo: userid)
        .get();
    final check2 = await FirebaseFirestore.instance
        .collection(reverseChatid)
        .where('userid', isEqualTo: friendid)
        .get();
    if (check1.size != 0) {
    } else if (check2.size != 0) {
      chatid = reverseChatid;
    }
    friendData = await FirebaseFirestore.instance
        .collection('users')
        .doc(friendid)
        .get();
    friendName = friendData['username'];
    friendImage = friendData['image'];
  }

  @override
  Widget build(BuildContext context) {
    final friendid = ModalRoute.of(context).settings.arguments as String;
    final userid = FirebaseAuth.instance.currentUser.uid;

    return FutureBuilder(
      future: getChatID(userid, friendid),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ))
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Color(0xff060930),
                    centerTitle: true,
                    title: Text(
                      userid == friendid ? 'Me To Me' : friendName,
                      style: KStyle.copyWith(color: Colors.white),
                    ),
                    actions: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(friendImage),
                      )
                    ],
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BuildListOfMessegs(chatid),
                      ),
                      SendMessege(userid, chatid),
                    ],
                  ),
                ),
    );
  }
}
