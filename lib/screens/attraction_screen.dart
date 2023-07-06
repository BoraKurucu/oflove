import 'package:flutter/material.dart';

class AttractionScreen extends StatefulWidget {
  @override
  _AttractionScreenState createState() => _AttractionScreenState();
}

class _AttractionScreenState extends State<AttractionScreen> {
  String? selectedGender;
  List<Map<String, dynamic>> genderOptions = [
    {'name': 'Male', 'icon': Icons.male},
    {'name': 'Female', 'icon': Icons.female},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender Screen'),
      ),
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
                          ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Selected Gender'),
                                    content:
                                        Text('You selected $selectedGender.'),
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
