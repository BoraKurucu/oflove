import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:oflove/screens/name_screen.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BirthdayScreen(),
    );
  }
}

class BirthdayScreen extends StatefulWidget {
  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  DateTime? selectedDate;
  bool isButtonEnabled = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isButtonEnabled = true;
      });
    }
  }

  void _checkAge() {
    if (selectedDate != null) {
      final now = DateTime.now();
      final age = now.difference(selectedDate!).inDays ~/ 365;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Age Verification'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (age >= 18) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NameScreen(),
                      ),
                    );
                  }
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Text(
                      'Oh, you must be new here.\nLet\'s get your birthdate.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        selectedDate != null
                            ? DateFormat('MMMM d, yyyy').format(selectedDate!)
                            : 'Select Date',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isButtonEnabled ? _checkAge : null,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
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
