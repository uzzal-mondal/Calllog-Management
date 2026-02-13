import 'package:call_log_management/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:call_log_management/model/notifymodel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notifications;
  final ApiService _service = ApiService();

  @override
  void initState() {
    super.initState();
    _notifications = _service.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,

        centerTitle: true,
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.blue, width: 1),
                ),
                child: ListTile(
                  leading: item.icon != null
                      ? Image.network(
                          item.icon.toString(),
                          width: 40,
                          height: 40,
                        )
                      : const Icon(Icons.notifications, size: 40),
                  title: Text(
                    item.title ?? "No Title",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.message ?? "No message"),
                  trailing: item.url != null
                      ? IconButton(
                          icon: const Icon(Icons.link),
                          onPressed: () {
                            // Open URL logic
                          },
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
