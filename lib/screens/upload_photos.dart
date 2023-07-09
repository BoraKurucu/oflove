import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oflove/screens/welcome_page.dart';

class UploadPhotosScreen extends StatefulWidget {
  DateTime? birthday = DateTime(1900);
  String? name = "empty";
  String? gender = "none";
  String? attraction_gender = "none";
  String? uid = "";
  String? email = "";

  UploadPhotosScreen({
    required this.uid,
    required this.email,
    required this.birthday,
    required this.name,
    required this.gender,
    required this.attraction_gender,
  });

  @override
  _UploadPhotosScreenState createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  List<PlatformFile> selectedImages = [];
  List<dynamic> profileImages = []; // Added profileImages list
  int currentIndex = 0;

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        selectedImages.addAll(result.files);
        currentIndex = selectedImages.length - 1;
      });
    }
  }

  Future<void> _uploadImages() async {
    if (selectedImages.isNotEmpty) {
      for (final image in selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        try {
          firebase_storage.Reference storageReference = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('$fileName.jpg');

          await storageReference.putData(image.bytes!);

          // Add the uploaded image name to the profileImages array
          String imageName = '$fileName.jpg';
          profileImages.add(imageName);

          // Convert DateTime to Timestamp

          // Create a new user document in Firestore
          await FirebaseFirestore.instance.collection('users').add({
            'uid': widget.uid,
            'email': widget.email,
            'birthday':
                widget.birthday.toString(), // Assign the converted Timestamp
            'name': widget.name,
            'gender': widget.gender,
            'attraction_gender': widget.attraction_gender,
            'profileImages': List<String>.from(profileImages),
            'messagingcost': "0",
            'callcost': "0",
            'videocost': "0",
            'rating': "0",
            'ratingcount': "0",
            'status': 'Offline',
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Upload Complete'),
                content: Text('The photos have been uploaded successfully.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          _continueWithoutPhotos();
        } catch (e) {
          print('Error uploading image: $e');
        }
      }
    }
  }

  void _goToPreviousPhoto() {
    setState(() {
      currentIndex = (currentIndex - 1).clamp(0, selectedImages.length - 1);
    });
  }

  void _goToNextPhoto() {
    setState(() {
      currentIndex = (currentIndex + 1).clamp(0, selectedImages.length - 1);
    });
  }

  void _removeSelectedPhoto() {
    setState(() {
      selectedImages.removeAt(currentIndex);
      if (selectedImages.isEmpty) {
        currentIndex = 0;
      } else if (currentIndex >= selectedImages.length) {
        currentIndex--;
      }
    });
  }

  void _continueWithoutPhotos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedImages.isNotEmpty
                        ? 'Great Choice! Add more photos to shine like a true star!'
                        : 'Great Choice! Upload your photos to shine like a true star!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImages,
                    child: Text(selectedImages.isNotEmpty
                        ? 'Add More Photos'
                        : 'Select Photos'),
                  ),
                  SizedBox(height: 20),
                  if (selectedImages.isNotEmpty)
                    Column(
                      children: [
                        Text(
                          'Selected Photos:',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.memory(
                              selectedImages[currentIndex].bytes!,
                              height: 400,
                              width: 400,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Opacity(
                                opacity: 1.0,
                                child: IconButton(
                                  onPressed: _removeSelectedPhoto,
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: _goToPreviousPhoto,
                                  icon: Icon(Icons.arrow_back),
                                  color: Colors.white,
                                ),
                                IconButton(
                                  onPressed: _goToNextPhoto,
                                  icon: Icon(Icons.arrow_forward),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _uploadImages,
                            child: Text('Finish and Upload Photos'),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _continueWithoutPhotos,
                    child: Text(
                      'Continue without photos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
