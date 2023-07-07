import 'package:flutter/material.dart';
import 'star_widget.dart';

class WelcomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: 'Search Stars...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: StarListWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showProfileOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Profile Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Manage Profile'),
                onTap: () {
                  // Implement the logic for managing the profile
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Manage Payments'),
                onTap: () {
                  // Implement the logic for managing payments
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () {
                  // Implement the logic for logging out
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
