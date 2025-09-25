import 'package:flutter/material.dart';
import '../models/notification_item.dart';

 class NotificationDetail extends StatelessWidget {
  final NotificationItem notif;
  const NotificationDetail({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Notifikasi")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: notif.color.withOpacity(0.2),
              child: Icon(notif.icon, color: notif.color, size: 40),
            ),
            Text(notif.title, style: TextStyle(color: notif.color)),
            Text(notif.message),
            Text("Waktu: ${notif.time}"),
          ],
        ),
      ),
    );
  }
}
