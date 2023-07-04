import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oflove/services/google_services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 400.0,
              height: 400.0,
            ),
            SizedBox(height: 24.0),
            Text(
              'Login with',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await GoogleSignInService.signInWithGoogle(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/google_logo.png',
                      width: 48.0,
                      height: 48.0,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () async {
                    try {
                      //sign in with apple is 30€/year, so not implemented until sponsorship
                      // You can now use the credential to authenticate the user
                      // Implement your authentication logic here
                    } catch (error) {
                      // Handle the sign-in error
                      //print('Error signing in with Apple: $error');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.apple,
                      size: 48.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    // Implement your Facebook login logic here
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 48.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
