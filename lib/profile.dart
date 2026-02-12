import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Username managed internally
  String userName = "John Doe";

  // Optional: Method to update username dynamically
  void updateUserName(String newName) {
    setState(() {
      userName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Avatar
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50, color: Colors.white),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 16),

          // User Name
          Text(
            userName,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),

          const SizedBox(height: 20),

          // Button to change username dynamically
          ElevatedButton(
            onPressed: () {
              // Demo: Change name when pressed
              updateUserName("Jane Doe");
            },
            child: const Text("Change Name"),
          ),
        ],
      ),
    );
  }
}
