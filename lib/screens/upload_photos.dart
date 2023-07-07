import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:oflove/screens/welcome_page.dart';

class UploadPhotosScreen extends StatefulWidget {
  @override
  _UploadPhotosScreenState createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  List<PlatformFile> selectedImages = [];
  int currentIndex = 0;

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        selectedImages.addAll(result.files);
        currentIndex =
            selectedImages.length - 1; // Set current index to the last image
      });
    }
  }

  Future<void> _uploadImages() async {
    if (selectedImages.isNotEmpty) {
      for (final image in selectedImages) {
        final Uint8List? bytes = image.bytes;

        if (bytes != null) {
          // Perform action to upload bytes to your desired destination.
          // Example: uploadBytesToServer(bytes);
        }
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Complete'),
            content: Text('So hot! The photos are uploaded ;)'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
        currentIndex = 0; // Set current index to 0 if all images are removed
      } else if (currentIndex >= selectedImages.length) {
        currentIndex--; // Adjust current index if the last image is removed
      }
    });
  }

  void _continueWithoutPhotos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
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
