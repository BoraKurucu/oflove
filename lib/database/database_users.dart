import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUser {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //reading other features to be added to this function
  Future<void> addUser(String email) async {
    return users
        .add({'email': email})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //getUser
  Future<List<Map<String, dynamic>>> getUser() async {
    List<Map<String, dynamic>> users = [];

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      snapshot.docs.forEach((doc) {
        if (doc.data() != null) {
          users.add(doc.data() as Map<String, dynamic>);
        }
      });

    // // Print the users array
    //   users.forEach((user) {
    //     print(user);
    //   });
    return users;

  }
}
