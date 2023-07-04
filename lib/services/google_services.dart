import 'package:google_sign_in/google_sign_in.dart';
import 'package:oflove/screens/welcome_page.dart';
import 'package:oflove/database/database_users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId:
        '644547860249-elrjtmcue9cb2f6p9ut2lipdrd6962ve.apps.googleusercontent.com',
  );

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleAccount =
          await _googleSignIn.signInSilently();
      if (googleAccount == null) {
        final GoogleSignInAccount? selectedAccount =
            await _googleSignIn.signIn();
        if (selectedAccount != null) {
          // Signed in successfully, handle the user account
          // You can access the user's basic profile information via `selectedAccount`
          // Perform your custom authentication logic here
          //DatabaseUser.add(selectedAccount.email!); // Add user to Firestore
          await DatabaseUser().addUser(selectedAccount.email!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ),
          );
        } else {
          // User canceled the sign-in flow
          // Handle accordingly
        }
      } else {
        // Already signed in with a Google account, handle the user account
        // You can access the user's basic profile information via `googleAccount`
        // Perform your custom authentication logic here

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
        );
      }
    } catch (error) {
      // Handle the sign-in error
      print('Error signing in with Google: $error');
    }
  }
}
