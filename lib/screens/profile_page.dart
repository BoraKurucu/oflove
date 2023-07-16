import 'package:flutter/material.dart';
import 'star_widget.dart';
import 'package:oflove/database/database_users.dart';
import 'package:oflove/entities/star.dart';


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