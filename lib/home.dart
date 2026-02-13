import 'package:call_log_management/api/api_constants.dart';
import 'package:call_log_management/more.dart';
import 'package:call_log_management/profile.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final String userName =
      ApiConstants.loginResponse.user!.displayName ?? "Unknown User";
  // Placeholder username

  final List<Widget> _pages = const [
    Center(child: Text("Home Page")),
    Center(child: Text("Create Issue Page")),
    MoreScreen(),
    //MorePage(), // Pass the user data to ProfilePage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        toolbarHeight: 80, // More space for 2 rows
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Row: Weather icon + Greeting
            Row(
              children: const [
                Icon(
                  Icons.wb_sunny, // Weather icon
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 6),
                Text(
                  "Good Morning",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Bottom Row: Profile icon + Username
            Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  child: Icon(
                    Icons.person, // Default profile icon
                    size: 24,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey, // Circle background
                ),
                const SizedBox(width: 8),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Create",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "more"),
        ],
      ),
    );
  }
}
