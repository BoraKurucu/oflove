import 'package:flutter/material.dart';
import 'package:oflove/screens/upload_photos.dart';

class AttractionScreen extends StatefulWidget {
  DateTime? birthday = DateTime(1900);
  String? name = "empty";
  String? gender = "none";
  String? uid = "";
  String? email = "";
  AttractionScreen(
      {required this.uid,
      required this.email,
      this.birthday,
      required this.name,
      required this.gender});
  @override
  _AttractionScreenState createState() => _AttractionScreenState();
}

class _AttractionScreenState extends State<AttractionScreen> {
  String? selectedGender;
  List<Map<String, dynamic>> genderOptions = [
    {'name': 'Male', 'icon': Icons.male},
    {'name': 'Female', 'icon': Icons.female},
  ];

  void _navigateToUploadPhotos() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UploadPhotosScreen(
              uid: widget.uid,
              email: widget.email,
              birthday: widget.birthday,
              name: widget.name,
              gender: widget.gender,
              attraction_gender: selectedGender)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 300,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Which gender are you looking for? Dont be shy ;)',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: genderOptions.map((gender) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              gender['icon'],
                              color: selectedGender == gender['name']
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                            title: Text(
                              gender['name'],
                              style: TextStyle(
                                fontSize: 24,
                                color: selectedGender == gender['name']
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedGender = gender['name'];
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: selectedGender != null
                          ? _navigateToUploadPhotos
                          : null,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
