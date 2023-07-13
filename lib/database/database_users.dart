import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oflove/entities/star.dart';

class DatabaseUser {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //reading other features to be added to this function
  Future<void> addUser(String email) async {
    return users
        .add({'email': email})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //getUsers
  Future<List<Map<String, dynamic>>> getUsers() async {
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

  Future<List<Star>> getData() async {
    List<Star> starsList = [];
    List<Map<String, dynamic>> users = [];

    users = await getUsers();

    for (int i = 0; i < users.length; i++) {
      starsList.add(
        Star(
          currentImageIndex: 0,
          profileImages: users[i]['profileImages'],
          attraction_gender: users[i]['attraction_gender'],
          birthday: users[i]['birthday'],
          callcost: users[i]['callcost'],
          email: users[i]['email'],
          gender: users[i]['gender'],
          messagingcost: users[i]['messagingcost'],
          name: users[i]['name'],
          ratingcount: users[i]['ratingcount'],
          status: users[i]['status'],
          uid: users[i]['uid'],
          videocost: users[i]['videocost'],
          rating: users[i]['rating'],
        ),
      );
    }
    return starsList;
  }

  Future<bool> checkUserExists(String userId) async {
    try {
      final DocumentSnapshot snapshot = await users.doc(userId).get();

      return snapshot.exists;
    } catch (error) {
      print('Error checking user existence: $error');
      return false;
    }
  }

  Future<String> getImageUrl(String imagename) async {
    final downloadURL =
        await FirebaseStorage.instance.ref().child(imagename).getDownloadURL();
    return downloadURL;
  }
}
