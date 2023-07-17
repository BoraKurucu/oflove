import 'package:flutter/material.dart';
import 'star_widget.dart';
import 'welcome_page.dart';
import 'package:oflove/database/database_users.dart';
import 'package:oflove/entities/star.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TEST');
    print(WelcomePage.userStar?.uid);
    String usertxt = (WelcomePage.userStar?.name).toString();
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 216,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      usertxt,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.grey[300],
                          child: InkWell(
                            onTap: () {
                              // Action to perform when the camera button is pressed
                            },
                            child: SizedBox(
                              width: 75,
                              height: 75,
                              child: Icon(Icons.create_outlined),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                      Transform.translate(
                        offset: Offset(0, 32), // Adjust the offset value as needed
                        child: ClipOval(
                          child: Material(
                            color: Colors.yellow,
                            child: InkWell(
                              onTap: () {
                                // Action to perform when the settings button is pressed
                              },
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Icon(Icons.add_a_photo_rounded),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                      Transform.translate(
                        offset: Offset(0, 0), // Adjust the offset value as needed
                        child: ClipOval(
                          child: Material(
                            color: Colors.grey[300],
                            child: InkWell(
                              onTap: () {
                                // Action to perform when the settings button is pressed
                              },
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Icon(Icons.settings),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: -300,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     width: double.infinity,
          //     height: 500,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.yellow,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


