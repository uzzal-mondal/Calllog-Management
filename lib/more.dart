import 'package:call_log_management/aboutus.dart';
import 'package:call_log_management/faq.dart';
import 'package:call_log_management/knowldege.dart';
import 'package:call_log_management/notify.dart';
import 'package:call_log_management/profile.dart';
import 'package:call_log_management/staticpages.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget buildCard({required Widget child}) {
    return Container(
      width: double.infinity, // match parent width
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// -------- Profile Card --------
                buildCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/300",
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// -------- Profile Options --------
                buildCard(
                  child: Column(
                    children: [
                      buildMenuItem(
                        icon: Icons.person,
                        title: "My Profile",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                      ),
                      buildMenuItem(
                        icon: Icons.lock,
                        title: "Change Password",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                /// -------- Other Options --------
                buildCard(
                  child: Column(
                    children: [
                      buildMenuItem(
                        icon: Icons.star_rate,
                        title: "Rate Us",
                        onTap: () {},
                      ),
                      buildMenuItem(
                        icon: Icons.help_outline,
                        title: "FAQ",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FaqScreen(),
                            ),
                          );
                        },
                      ),

                      buildMenuItem(
                        icon: Icons.book_outlined,
                        title: "Knowledge Base",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KnowledgeBaseScreen(),
                            ),
                          );
                        },
                      ),

                      buildMenuItem(
                        icon: Icons.book_outlined,
                        title: "Notification",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotificationScreen(),
                            ),
                          );
                        },
                      ),

                      buildMenuItem(
                        icon: Icons.info_outline,
                        title: "About Us",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StaticContentPage(
                                title: "About Us",
                                keyName: "AboutUs",
                              ),
                            ),
                          );
                        },
                      ),

                      buildMenuItem(
                        icon: Icons.info_outline,
                        title: "Privacy Policy",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StaticContentPage(
                                title: "Privacy Policy",
                                keyName: "PrivacyPolicy",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// -------- Logout Button --------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Logout logic
                    },
                    // icon: const Icon(Icons.logout),
                    label: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
