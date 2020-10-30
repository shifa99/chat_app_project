import 'package:chat_app/Screens/ProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(BuildContext context, String userid) {
  return AppBar(
    title: Text('Chat Home'),
    centerTitle: true,
    backgroundColor: Color(0xff333456),
    actions: [
      DropdownButton(
        underline: Container(),
        icon: Icon(Icons.more_vert),
        items: [
          DropdownMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.exit_to_app),
                Text('Logout'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'setting',
            child: Row(
              children: [
                Icon(Icons.settings),
                Text('Setting'),
              ],
            ),
          ),
        ],
        onChanged: (value) async {
          if (value == 'logout') FirebaseAuth.instance.signOut();
          if (value == 'setting') {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }
        },
      ),
    ],
  );
}
