import 'dart:io';
import 'package:chat_app/Services/Auth.dart';
import 'package:chat_app/Services/Constants.dart';
import 'package:chat_app/Widgets/BuildSpeedDial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loginMode = true;
  bool _isLoged = true;
  bool _isLoaded = false;
  final _formKey = GlobalKey<FormState>();
  final focusPassword = FocusNode();
  final focusCofirmPassword = FocusNode();

  final _controllerPassword = TextEditingController();
  String email, username, password;
  File _image;
  // final picker = ImagePicker();
  void saved(BuildContext ctx) {
    if (!_formKey.currentState.validate()) return;
    if (_image == null && !loginMode) {
      showDialog(
          context: ctx,
          builder: (ctx) => AlertDialog(
                content: Text(
                  'Please Picked an Image',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                backgroundColor: Theme.of(ctx).errorColor,
              ));
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoaded = true;
    });
    FocusScope.of(context).unfocus(); //to close Keyboard
    _isLoged = loginMode ? true : false;
    authenticate(email, password, _isLoged, username, _image, ctx);

    setState(() {
      _isLoaded = false;
    });
    !loginMode
        ? setState(() {
            loginMode = true;
          })
        : null;
  }

  Future<void> getImage(ImageSource src) async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: src, imageQuality: 60, maxWidth: 140);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: !loginMode ? BuildSpeedDial(getImage) : null,
          backgroundColor: Color(0xff333456),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!loginMode)
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xfff4abc4),
                      backgroundImage:
                          _image != null ? FileImage(_image) : null,
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                        height:
                            loginMode ? heightScreen * 0.6 : heightScreen * 0.7,
                        width: 340,
                        decoration: BoxDecoration(
                            color: Color(0xfff4abc4),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextFormField(
                                      key: ValueKey('E-Mail'),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: buildDecoration(
                                          'E-Mail', Icons.email),
                                      validator: (email) {
                                        if (email.isEmpty)
                                          return 'Please Enter Your Email';
                                        else if (!email.contains('@'))
                                          return 'Please Enter Valid Email';
                                        return null;
                                      },
                                      onSaved: (newEmail) {
                                        email = newEmail;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (!loginMode)
                                      TextFormField(
                                        key: ValueKey('username'),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: buildDecoration(
                                            'Username',
                                            Icons
                                                .supervised_user_circle_outlined),
                                        validator: (username) {
                                          if (username.isEmpty)
                                            return 'Please Enter Your UserName';
                                          return null;
                                        },
                                        onSaved: (newEmail) {
                                          username = newEmail;
                                        },
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(focusPassword);
                                        },
                                      ),
                                    if (!loginMode)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    TextFormField(
                                      focusNode: focusPassword,
                                      key: ValueKey('Password'),
                                      textInputAction: loginMode
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                      controller: _controllerPassword,
                                      obscureText: true,
                                      decoration: buildDecoration(
                                          'Password', Icons.vpn_key),
                                      validator: (password) {
                                        if (password.isEmpty)
                                          return 'Please Enter Password';
                                        else if (password.length < 7)
                                          return 'Your Password Is Short';
                                        return null;
                                      },
                                      onSaved: (newPassword) {
                                        password = newPassword;
                                      },
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(focusCofirmPassword);
                                      },
                                    ),
                                    if (!loginMode)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (!loginMode)
                                      TextFormField(
                                        focusNode: focusCofirmPassword,
                                        key: ValueKey('Confirm-Password'),
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        decoration: buildDecoration(
                                            'Confirm-Password', Icons.vpn_key),
                                        validator: (confirmPassword) {
                                          if (confirmPassword.isEmpty)
                                            return 'Please Enter Confirm-Password';
                                          else if (confirmPassword !=
                                              _controllerPassword.text)
                                            return 'Your Password Is Difference';
                                          return null;
                                        },
                                      ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RaisedButton(
                                      child: _isLoaded
                                          ? CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                            )
                                          : Text(
                                              (loginMode
                                                  ? 'Log In'
                                                  : 'Sign Up'),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                      color: Color(0xff060930),
                                      onPressed: () {
                                        saved(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  loginMode
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Can\'t Have An Account ?',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            RaisedButton(
                              child: Text('SignUp',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              color: Color(0xfff4abc4),
                              onPressed: () {
                                setState(() {
                                  loginMode = false;
                                });
                              },
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }
}
