import 'package:flutter/material.dart';
import 'login_page.dart';
import '../models/notification_item.dart';
import 'data_jalan_page.dart';

class DashboardAdmin extends StatelessWidget {
  final String username; // ✅ Tambah variabel username

  const DashboardAdmin({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final List<NotificationItem> notifications = [
      NotificationItem(
        title: "Jalan Raya Sarangan",
        message: "Lubang diameter ±40cm terdeteksi.",
        color: Colors.red,
        icon: Icons.warning,
        time: "10 menit lalu",
      ),
      NotificationItem(
        title: "Drone Survey Maospati",
        message: "Menemukan 5 kerusakan jalan.",
        color: Colors.green,
        icon: Icons.notifications_active,
        time: "1 jam lalu",
      ),
      NotificationItem(
        title: "Perbaikan Jalan",
        message: "3 jalan rusak sudah diperbaiki.",
        color: Colors.blue,
        icon: Icons.check_circle,
        time: "Kemarin",
      ),
    ];

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFF09819)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                "Dash UI",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.traffic),
              title: const Text("Data Jalan"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DataJalanPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("Statistik"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Pengaturan"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),

      // ✅ Ganti title dengan username
      appBar: AppBar(
        title: Text("Halo, $username 👋"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF512F), Color(0xFFF09819)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    notifications.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFF09819)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Deteksi Dini Kerusakan Jalan dan Potensi Bahaya\nBerbasis Citra Satelit dan Drone",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Image.asset("assets/images/logo.png", width: 80),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                _buildStatCard("Jalan Rusak", "20", Colors.red),
                const SizedBox(width: 12),
                _buildStatCard("Sudah Ditangani", "11", Colors.green),
                const SizedBox(width: 12),
                _buildStatCard("Belum Ditangani", "14", Colors.blue),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "Pembaruan Informasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationCard(context, notif);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(title, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationItem notif) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notif.color.withOpacity(0.2),
          child: Icon(notif.icon, color: notif.color),
        ),
        title: Text(
          notif.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: notif.color),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notif.message),
            const SizedBox(height: 4),
            Text(
              notif.time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
