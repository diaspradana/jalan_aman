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
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: _buildAppBar(context, notifications.length),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1024) {
            // Desktop layout with sidebar
            return Row(
              children: [
                // Sidebar
                Container(
                  width: 250,
                  color: const Color(0xFF16213E),
                  child: _buildSidebar(context),
                ),
                // Main Content
                Expanded(
                  child: Container(
                    color: const Color(0xFF0F0F23),
                    child: _buildMainContent(context, notifications),
                  ),
                ),
              ],
            );
          } else {
            // Mobile/tablet layout
            return Container(
              color: const Color(0xFF0F0F23),
              child: _buildMainContent(context, notifications),
            );
          }
        },
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),

              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const Divider(color: Colors.grey, height: 1),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _buildSidebarItem(Icons.dashboard, "Dashboard", true, () {}),
              _buildSidebarItem(Icons.traffic, "Data Jalan", false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DataJalanPage()),
                );
              }),
              _buildSidebarItem(Icons.analytics, "Statistik", false, () {}),
              _buildSidebarItem(Icons.settings, "Pengaturan", false, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.grey[400],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey[400],
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: isSelected ? Colors.orange.withOpacity(0.1) : Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.grey[400],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey[400],
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: isSelected ? Colors.orange.withOpacity(0.1) : Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, int notificationCount) {
    return AppBar(
      backgroundColor: const Color(0xFF0F0F23),
      elevation: 0,
      title: Text(
        "Halo, $username 👋",
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        Container(
          width: 250,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari data jalan...",
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              filled: true,
              fillColor: const Color(0xFF1A1A2E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
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
                  notificationCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            username.isNotEmpty ? username[0].toUpperCase() : "A",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          color: const Color(0xFF1A1A2E),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Profile", style: TextStyle(color: Colors.grey[300])),
              value: "profile",
            ),
            PopupMenuItem(
              child: Text("Settings", style: TextStyle(color: Colors.grey[300])),
              value: "settings",
            ),
            PopupMenuItem(
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
              value: "logout",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, List<NotificationItem> notifications) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Banner dengan animasi
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 20), // slide dari bawah
                  child: child,
                ),
              );
            },
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // lebih kecil
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
                // 🔹 Bagian teks
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jalan Aman Kota Nyaman",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width > 1000 ? 20 : 16, // diperkecil
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Deteksi Dini Kerusakan Jalan dan Potensi Bahaya\n"
                        "Berbasis Citra Satelit dan Drone",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: MediaQuery.of(context).size.width > 1000 ? 14 : 12, // diperkecil
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // 🔹 Logo lebih kecil & responsif
                SizedBox(
                  width: MediaQuery.of(context).size.width > 1000 ? 55 : 45, // otomatis kecil di layar kecil
                  height: MediaQuery.of(context).size.width > 1000 ? 55 : 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),

          const SizedBox(height: 30),

          // 🔹 Statistik dengan animasi
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1000),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 30), // slide lebih jauh
                  child: child,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Statistik Kerusakan Jalan",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      return Row(
                        children: [
                          Expanded(child: _buildStatCard("Jalan Rusak", "20", "Total kerusakan terdeteksi", Icons.warning, Colors.red)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildStatCard("Sudah Ditangani", "11", "Perbaikan selesai", Icons.check_circle, Colors.green)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildStatCard("Belum Ditangani", "14", "Menunggu perbaikan", Icons.pending, Colors.blue)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildStatCard("Survey Hari Ini", "5", "Pemindaian drone", Icons.flight, Colors.orange)),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _buildStatCard("Jalan Rusak", "20", "Total kerusakan terdeteksi", Icons.warning, Colors.red)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildStatCard("Sudah Ditangani", "11", "Perbaikan selesai", Icons.check_circle, Colors.green)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(child: _buildStatCard("Belum Ditangani", "14", "Menunggu perbaikan", Icons.pending, Colors.blue)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildStatCard("Survey Hari Ini", "5", "Pemindaian drone", Icons.flight, Colors.orange)),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 🔹 Notifikasi & Road Status dengan animasi
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1200),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 40), // lebih jauh
                  child: child,
                ),
              );
            },
            child: LayoutBuilder(
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
                            const Text(
                              "Pembaruan Informasi",
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
                      const Text(
                        "Pembaruan Informasi",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildNotificationsList(context, notifications),
                      const SizedBox(height: 24),
                      _buildRoadStatusOverview(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(BuildContext context, List<NotificationItem> notifications) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: notifications.map((notif) => _buildNotificationCard(context, notif)).toList(),
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, NotificationItem notif) {
    return GestureDetector(
      onTap: () {
        // 🔹 Dialog dengan animasi fade + slide
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Detail Notifikasi",
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) {
            return Center(
              child: Dialog(
                backgroundColor: const Color(0xFF1A1A2E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: notif.color.withOpacity(0.2),
                        child: Icon(notif.icon, color: notif.color, size: 40),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        notif.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: notif.color,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notif.message,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Waktu: ${notif.time}",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Tutup",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final fade = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            final slide = Tween<Offset>(
              begin: const Offset(0, 0.2), // muncul dari bawah
              end: Offset.zero,
            ).animate(fade);

            return FadeTransition(
              opacity: fade,
              child: SlideTransition(position: slide, child: child),
            );
          },
        );
      },
      child: Container(
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
                  Text(
                    notif.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: notif.color,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notif.time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          const Text(
            "Status Jalan Overview",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Progress Indicator
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "65%",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Kondisi Baik",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Status breakdown
          _buildStatusItem(Icons.check_circle, "Jalan Baik", "65% dari total", "450 Km", Colors.green),
          const SizedBox(height: 12),
          _buildStatusItem(Icons.warning, "Perlu Perbaikan", "20% dari total", "138 Km", Colors.orange),
          const SizedBox(height: 12),
          _buildStatusItem(Icons.dangerous, "Rusak Berat", "15% dari total", "103 Km", Colors.red),
          const SizedBox(height: 16),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF512F), Color(0xFFF09819)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Lihat Detail Lengkap",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String title, String subtitle, String distance, Color color) {
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
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          distance,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}