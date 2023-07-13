import 'package:flutter/material.dart';
import 'package:oflove/screens/attraction_screen.dart';
import 'package:oflove/screens/login_screen.dart';
import 'package:oflove/screens/birthday_screen.dart';
import 'package:oflove/screens/upload_photos.dart';
import 'package:oflove/screens/welcome_page.dart';
import 'package:oflove/database/database_users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // Replace with actual values
      options: FirebaseOptions(
    apiKey: "AIzaSyDdsaxlQ8wOmySNyXnnBsCfiwJtwzlMnzA",
    appId: "1:644547860249:android:dc5b68093a492ca5305788",
    messagingSenderId: "644547860249",
    projectId: "oflove-fa0cb",
    storageBucket: "oflove-fa0cb.appspot.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      /*
      home: BirthdayScreen(
        uid: "test_id6",
        email: "test@mail.com",
      ),
      */
      home: WelcomePage(),
    );
  }
}
