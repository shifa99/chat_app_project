import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

class BuildSpeedDial extends StatelessWidget {
  Function getImage;
  BuildSpeedDial(this.getImage);
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        backgroundColor: Color(0xff060930),
        child: Icon(Icons.add_a_photo_sharp),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: Icon(Icons.add_a_photo),
              label: 'Camera',
              onTap: () => getImage(ImageSource.camera)),
          SpeedDialChild(
              child: Icon(Icons.image),
              label: 'Gallery',
              onTap: () => getImage(ImageSource.gallery))
        ]);
  }
}
