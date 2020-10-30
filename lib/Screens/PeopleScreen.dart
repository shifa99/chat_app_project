import 'package:chat_app/Screens/ChatWithFriend.dart';
import 'package:chat_app/Services/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PeopleScreen extends StatelessWidget {
  static String routeName = 'PeopleScreen';
  @override
  Widget build(BuildContext context) {
    final data1 = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff333456),
        title: Text(
          'Friends Chats',
          style: KStyle.copyWith(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: data1.snapshots(),
        builder: (ctx, snapshots) => snapshots.connectionState ==
                ConnectionState.waiting
            ? CircularProgressIndicator(
                backgroundColor: Colors.red,
              )
            : ListView.builder(
                itemCount: snapshots.data.docs.length,
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ChatWithFriend.routeName,
                        arguments: snapshots.data.docs[i]['userid']);
                    // print(snapshots.data.docs[i]['userid']);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.pink[200],
                          Color(0xff060930),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                NetworkImage(snapshots.data.docs[i]['image']),
                            backgroundColor: Colors.pinkAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              snapshots.data.docs[i]['username'],
                              textAlign: TextAlign.center,
                              style: KStyle.copyWith(
                                  fontSize: 22, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
