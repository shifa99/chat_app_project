import 'package:chat_app/Screens/ChatScreen.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/ProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localeResolutionCallback: (currentLocale, supported) {
        if (currentLocale != null) {
          print(currentLocale.countryCode);
          return currentLocale;
        }
        return supported.first;
      },
      theme: ThemeData(
          buttonTheme: ButtonTheme.of(context).copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )),
      routes: {
        // '/': (context) => HomeScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        ProfileScreen.routeName: (context) =>
            ProfileScreen(userid: FirebaseAuth.instance.currentUser.uid),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) =>
            snapshot.hasData ? ChatScreen() : HomeScreen(),
      ),
    );
  }
}
