import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendMessege extends StatefulWidget {
  final userid;
  SendMessege(this.userid);
  @override
  _SendMessegeState createState() => _SendMessegeState();
}

class _SendMessegeState extends State<SendMessege> {
  final _controller = TextEditingController();
  String messege;
  File _image;
  var ref;
  var url;
  void _sendMessege(int typeMessege) async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    if (messege == '' && typeMessege == 0) return;
    if (_image == null && typeMessege == 1) return;
    // final userid = FirebaseAuth.instance.currentUser.uid;
    //index 0 to refer send text
    //index 1 to refer send Photo
    if (typeMessege == 1) {
      ref = FirebaseStorage.instance
          .ref()
          .child('user_chats')
          .child(widget.userid + Timestamp.now().toString() + '.jpg');
      await ref.putFile(_image);
      url = await ref.getDownloadURL();
    }
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .get();

    await FirebaseFirestore.instance.collection('newchats').add({
      'text': typeMessege == 0 ? messege : url,
      'createdAt': Timestamp.now(),
      'username': userdata['username'],
      'imageurl': userdata['image'],
      'userid': widget.userid,
      'typeMessege': typeMessege,
    });
    messege = null;
    _image = null;
  }

  Future<void> getImage(ImageSource src) async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: src, imageQuality: 60, maxWidth: 170);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextField(
        textInputAction: TextInputAction.done,
        controller: _controller,
        autocorrect: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (mess) {
          setState(() {
            messege = mess;
          });
        },
        decoration: InputDecoration(
          hintText: 'Enter Messege Here',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: IconButton(
            icon: Icon(
              Icons.photo,
            ),
            onPressed: () async {
              await getImage(ImageSource.gallery);
              _sendMessege(1);
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: messege != null
                ? () {
                    _sendMessege(0);
                  }
                : null,
          ),
        ),
      )),
    ]);
  }
}
