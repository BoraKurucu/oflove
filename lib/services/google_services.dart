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
      final GoogleSignInAccount? googleAccount = _googleSignIn.currentUser;

      if (googleAccount == null || !await _googleSignIn.isSignedIn()) {
        final GoogleSignInAccount? selectedAccount =
            await _googleSignIn.signIn();

        if (selectedAccount != null) {
          await selectedAccount.authentication;

          await DatabaseUser().addUser(selectedAccount.email!);
        } else {
          return; // User canceled the sign-in flow
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }
}
