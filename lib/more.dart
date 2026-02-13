import 'package:call_log_management/faq.dart';
import 'package:call_log_management/knowldege.dart';
import 'package:call_log_management/notify.dart';
import 'package:call_log_management/profile.dart';
import 'package:call_log_management/staticpages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  Widget buildMenuItem({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: icon, // direct widget
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
                        icon: const Icon(Icons.person, color: Colors.blue),
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
                        icon: const Icon(Icons.lock, color: Colors.blue),
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
                        icon: const FaIcon(FontAwesomeIcons.star, size: 20),
                        title: "Rate Us",
                        onTap: () {},
                      ),
                      buildMenuItem(
                        icon: const Icon(
                          Icons.help_outline,
                          color: Colors.blue,
                        ),

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
                        icon: const FaIcon(
                          FontAwesomeIcons.book,
                          size: 20,
                          color: Colors.blue,
                        ),
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
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.blue,
                        ),
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
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
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
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
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
