import 'package:flutter/material.dart';
import '../models/notification_item.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_sidebar.dart';

class DashboardAdmin extends StatefulWidget {
  final String username;

  const DashboardAdmin({super.key, required this.username});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  String selectedMenu = "Dashboard";

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
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // ✅ Desktop layout
            if (constraints.maxWidth > 1024) {
              return Row(
                children: [
                  // 🔹 Sidebar di kiri
                  CustomSidebar(
                    selectedMenu: selectedMenu,
                    onSelect: (menu) {
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                  ),

                  // 🔹 Area utama
                  Expanded(
                    child: Column(
                      children: [
                        // 🔹 Navbar di atas (UPDATE: dengan searchData)
                        CustomNavbar(
                          username: widget.username,
                          notificationCount: notifications.length,
                          searchData:
                              notifications.map((n) => n.title).toList(), // ✅ Kirim data notifikasi ke search
                        ),

                        // 🔹 Isi dashboard
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: _buildDashboardContent(
                                context, notifications),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            // ✅ Mobile layout
            else {
              return Column(
                children: [
                  CustomNavbar(
                    username: widget.username,
                    notificationCount: notifications.length,
                    searchData:
                        notifications.map((n) => n.title).toList(), // ✅ Sama seperti versi desktop
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: _buildDashboardContent(
                          context, notifications),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // 🔹 Konten utama dashboard
  Widget _buildDashboardContent(BuildContext context, List<NotificationItem> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF512F), Color(0xFFF09819)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jalan Aman Kota Nyaman",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width > 1000 ? 20 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Deteksi Dini Kerusakan Jalan dan Potensi Bahaya\nBerbasis Citra Satelit dan Drone",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize:
                            MediaQuery.of(context).size.width > 1000 ? 14 : 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width > 1000 ? 55 : 45,
                height:
                    MediaQuery.of(context).size.width > 1000 ? 55 : 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/images/logo.png",
                      fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // 🔹 Statistik
        const Text(
          "Statistik Kerusakan Jalan",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                children: [
                  Expanded(
                      child: _buildStatCard("Jalan Rusak", "20",
                          "Total kerusakan terdeteksi", Icons.warning,
                          Colors.red)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildStatCard("Sudah Ditangani", "11",
                          "Perbaikan selesai", Icons.check_circle,
                          Colors.green)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildStatCard("Belum Ditangani", "14",
                          "Menunggu perbaikan", Icons.pending,
                          Colors.blue)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildStatCard("Survey Hari Ini", "5",
                          "Pemindaian drone", Icons.flight,
                          Colors.orange)),
                ],
              );
            } else {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildStatCard("Jalan Rusak", "20",
                              "Total kerusakan terdeteksi", Icons.warning,
                              Colors.red)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildStatCard("Sudah Ditangani", "11",
                              "Perbaikan selesai", Icons.check_circle,
                              Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _buildStatCard("Belum Ditangani", "14",
                              "Menunggu perbaikan", Icons.pending,
                              Colors.blue)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildStatCard("Survey Hari Ini", "5",
                              "Pemindaian drone", Icons.flight,
                              Colors.orange)),
                    ],
                  ),
                ],
              );
            }
          },
        ),

        const SizedBox(height: 30),

        // 🔹 Notifikasi & Status Jalan
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1000) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Pembaruan Informasi",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _buildNotificationsList(context, notifications),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(width: 300, child: _buildRoadStatusOverview()),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Pembaruan Informasi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildNotificationsList(context, notifications),
                  const SizedBox(height: 24),
                  _buildRoadStatusOverview(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // 🔸 Kartu Statistik
  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            Text(value,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ]),
          const SizedBox(height: 12),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        ],
      ),
    );
  }

  // 🔸 List Notifikasi
  Widget _buildNotificationsList(BuildContext context, List<NotificationItem> notifications) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: notifications
            .map((notif) => _buildNotificationCard(context, notif))
            .toList(),
      ),
    );
  }

  // 🔸 Kartu Notifikasi
  Widget _buildNotificationCard(BuildContext context, NotificationItem notif) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F23),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: notif.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(notif.icon, color: notif.color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notif.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: notif.color,
                        fontSize: 16)),
                const SizedBox(height: 4),
                Text(notif.message,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 8),
                Text(notif.time,
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey[400])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔸 Status Jalan
  Widget _buildRoadStatusOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Status Jalan Overview",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0F0F23),
                    border: Border.all(color: Colors.green, width: 8),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0F0F23),
                    border: Border.all(color: Colors.red, width: 6),
                  ),
                ),
                const Column(
                  children: [
                    Text("65%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Kondisi Baik",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildStatusItem(Icons.check_circle, "Jalan Baik", "65% dari total",
              "450 Km", Colors.green),
          const SizedBox(height: 12),
          _buildStatusItem(Icons.warning, "Perlu Perbaikan", "20% dari total",
              "138 Km", Colors.orange),
          const SizedBox(height: 12),
          _buildStatusItem(Icons.dangerous, "Rusak Berat", "15% dari total",
              "103 Km", Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String title, String subtitle,
      String distance, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              Text(subtitle,
                  style:
                      TextStyle(color: Colors.grey[400], fontSize: 12)),
            ],
          ),
        ),
        Text(distance,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
