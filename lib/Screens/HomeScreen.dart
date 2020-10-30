import 'package:chat_app/Screens/ChatScreen.dart';
import 'package:chat_app/Screens/PeopleScreen.dart';
import 'package:chat_app/Services/Constants.dart';
import 'package:chat_app/Widgets/BuildAppBar.dart';
import 'package:chat_app/Widgets/BuildCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser.uid;
    return SafeArea(
      child: Scaffold(
          appBar: buildAppBar(context, userid),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 370,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'Images/logo-.png',
                  fit: BoxFit.cover,
                ),
              ),
              BuildCard('Images/5f9b4252009bd.jpg', 'Group Chat', () {
                Navigator.pushNamed(context, ChatScreen.routeName);
              }),
              BuildCard('Images/5f9b42e857eee.jpg', 'One To One Chat', () {
                Navigator.pushNamed(context, PeopleScreen.routeName);
              }),
            ],
          )),
    );
  }
}
