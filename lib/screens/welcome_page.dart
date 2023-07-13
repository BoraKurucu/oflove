import 'package:flutter/material.dart';
import 'star_widget.dart';
import 'package:oflove/database/database_users.dart';
import 'package:oflove/entities/star.dart';

class WelcomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  String? uid = "";
  Star? userStar;

  WelcomePage({
    required this.uid,
  }) {
    initializeUserStar();
  }

  void initializeUserStar() async {
    DatabaseUser databaseUser = DatabaseUser();
    userStar = await databaseUser.getStarByUid(uid.toString());
    // Use the userStar object as needed
    if (userStar != null) {
      // Perform actions with userStar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search Stars...',
                            hintStyle: TextStyle(color: Colors.grey[300]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        _openProfile(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StarListWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          // Replace this with the widget representing the profile page
          return ProfilePage();
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
