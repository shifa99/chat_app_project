import 'package:flutter/material.dart';

class BuildListTile extends StatelessWidget {
  final icon;
  final source;
  final pressed;
  BuildListTile(this.icon, this.source, this.pressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      color: Colors.teal,
      child: ListTile(
        leading: Icon(
          icon,
        ),
        title: Text(source),
        onTap: pressed,
      ),
    );
  }
}
