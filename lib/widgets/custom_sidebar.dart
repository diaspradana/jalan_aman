import 'package:flutter/material.dart';
import '../views/data_jalan_page.dart';
import '../views/dashboard_admin.dart'; 
import '../views/peta_interaktif_page.dart';

class CustomSidebar extends StatelessWidget {
  final Function(String) onSelect;
  final String selectedMenu;

  const CustomSidebar({
    super.key,
    required this.onSelect,
    required this.selectedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF16213E),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildSidebarItem(context, Icons.dashboard, "Dashboard"),
                _buildSidebarItem(context, Icons.traffic, "Data Jalan"),
                _buildSidebarItem(context, Icons.map, "Peta Interaktif"),
                _buildSidebarItem(context, Icons.analytics, "Statistik"),
                _buildSidebarItem(context, Icons.settings, "Pengaturan"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, IconData icon, String title) {
    final isSelected = selectedMenu == title;
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
        onTap: () {
          onSelect(title);

          // 🔹 Navigasi ke masing-masing halaman
          if (title == "Dashboard") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const DashboardAdmin(username: "Admin"),
              ),
            );
          } else if (title == "Data Jalan") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DataJalanPage()),
            );
          } else if (title == "Peta Interaktif") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PetaInteraktifPage()),
            );
          } else if (title == "Statistik") {
            // Tambahkan navigasi ke halaman Statistik jika ada
          } else if (title == "Pengaturan") {
            // Tambahkan navigasi ke halaman Pengaturan jika ada
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor:
            isSelected ? Colors.orange.withOpacity(0.1) : Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
