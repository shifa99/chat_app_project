import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<void> authenticate(String email, String password, bool isLoged,
    String username, File image, BuildContext context) async {
  final auth = FirebaseAuth.instance;
  try {
    if (isLoged) {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(userCredential.user.uid + '.jpg');
      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user.uid)
          .set({
        'username': username,
        'password': password,
        'email': email,
        'image': url
      });
    }
  } on FirebaseAuthException catch (e) {
    String errorMessege = '';
    if (e.code == 'weak-password') {
      errorMessege = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      errorMessege = 'The account already exists for that email.';
    } else if (e.code == 'user-not-found') {
      errorMessege = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessege = 'Wrong password provided for that user.';
    }
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Some Errors Appear'),
              content: Text(errorMessege),
              actions: [
                FlatButton(
                  child: Text('OKEY'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  } catch (e) {
    print(e);
    print("hee");
  }
}
