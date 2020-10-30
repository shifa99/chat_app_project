import 'package:chat_app/Services/Constants.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final imagePath;
  final name;
  final pressed;
  BuildCard(this.imagePath, this.name, this.pressed);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff060930),
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(
              name,
              style: KStyle.copyWith(fontSize: 22, color: Colors.white),
            ),
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.pink,
              backgroundImage: AssetImage(imagePath),
            ),
            onTap: () => pressed()),
      ),
    );
  }
}
