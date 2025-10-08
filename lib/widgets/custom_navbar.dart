import 'package:flutter/material.dart';
import '../views/login_page.dart';

class CustomNavbar extends StatefulWidget implements PreferredSizeWidget {
  final String username;
  final int notificationCount;
  final List<String> searchData;
  final Function(String)? onSearch; // ✅ tambahan callback untuk parent

  const CustomNavbar({
    super.key,
    required this.username,
    required this.notificationCount,
    required this.searchData,
    this.onSearch,
  });

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomNavbarState extends State<CustomNavbar> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredResults = [];

  void _onSearchChanged(String query) {
    final lowerQuery = query.toLowerCase();

    // 🔹 Jalankan callback ke parent (mis. DataJalanPage)
    if (widget.onSearch != null) widget.onSearch!(lowerQuery);

    // 🔹 Filter hasil suggestion lokal
    setState(() {
      filteredResults = widget.searchData
          .where((item) => item.toLowerCase().contains(lowerQuery))
          .toList();
    });
  }

  void _showSearchResults(BuildContext context, String query) {
    final results = widget.searchData
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          "Hasil Pencarian untuk: \"$query\"",
          style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        content: results.isEmpty
            ? const Text("Tidak ada hasil ditemukan.",
                style: TextStyle(color: Colors.white70))
            : SizedBox(
                height: 200,
                width: 400,
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: const Icon(Icons.description, color: Colors.orange),
                    title: Text(results[i],
                        style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black87,
                          content: Text("Membuka ${results[i]}...",
                              style: const TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  ),
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup", style: TextStyle(color: Colors.orange)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0F0F23),
      elevation: 0,
      title: Text(
        "Halo, ${widget.username} 👋",
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        // 🔎 Search Bar
        Container(
          width: 250,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              TextField(
                controller: _searchController,
                onChanged: _onSearchChanged, // ✅ sekarang cocok
                decoration: InputDecoration(
                  hintText: "Cari laporan atau jalan...",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFF1A1A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  if (value.isNotEmpty) _showSearchResults(context, value);
                },
              ),

              // 🔽 Dropdown suggestion
              if (filteredResults.isNotEmpty &&
                  _searchController.text.isNotEmpty)
                Positioned(
                  top: 48,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.withOpacity(0.4)),
                    ),
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: filteredResults.length,
                      itemBuilder: (_, index) {
                        final item = filteredResults[index];
                        return ListTile(
                          title: Text(item,
                              style: const TextStyle(color: Colors.white)),
                          leading: const Icon(Icons.location_on,
                              color: Colors.orange),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _searchController.text = item;
                            filteredResults.clear();
                            _showSearchResults(context, item);
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 20),

        // 🔔 Notification
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
                  widget.notificationCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),

        // 👤 Profile + Menu
        CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            widget.username.isNotEmpty
                ? widget.username[0].toUpperCase()
                : "A",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          color: const Color(0xFF1A1A2E),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "profile",
              child: Text("Profile", style: TextStyle(color: Colors.grey[300])),
            ),
            PopupMenuItem(
              value: "settings",
              child: Text("Settings", style: TextStyle(color: Colors.grey[300])),
            ),
            PopupMenuItem(
              value: "logout",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
