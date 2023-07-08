import 'package:flutter/material.dart';
import 'package:oflove/screens/attraction_screen.dart';

class GenderScreen extends StatefulWidget {
  DateTime? birthday = DateTime(1900);
  String? name = "empty";
  String? uid = "";
  String? email = "";
  GenderScreen(
      {required this.uid,
      required this.email,
      this.birthday,
      required this.name});

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;
  List<Map<String, dynamic>> genderOptions = [
    {'name': 'Male', 'icon': Icons.male},
    {'name': 'Female', 'icon': Icons.female},
  ];

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
                      'Amazing name! Now let me know your gender!',
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
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AttractionScreen(
                                      uid: widget.uid,
                                      email: widget.email,
                                      birthday: widget.birthday,
                                      name: widget.name,
                                      gender: selectedGender),
                                ),
                              );
                            }
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
