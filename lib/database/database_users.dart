import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUser {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String email) async {
    return users
        .add({'email': email})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
