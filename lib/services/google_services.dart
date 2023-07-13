import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oflove/screens/birthday_screen.dart';
import 'package:oflove/screens/welcome_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oflove/database/database_users.dart';

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

          String userId = selectedAccount.id;
          bool userExists = await DatabaseUser().checkUserExists(userId);

          if (!userExists) {
            // User does not exist in the database
            // Perform actions for first-time sign-in
            // For example, navigate to the BirthdayScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BirthdayScreen(uid: userId, email: selectedAccount.email),
              ),
            );
          } else {
            // User already exists in the database
            // Perform actions for returning users
            // For example, navigate to the WelcomePage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(uid: userId),
              ),
            );
          }
        } else {
          return; // User canceled the sign-in flow
        }
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }
}
