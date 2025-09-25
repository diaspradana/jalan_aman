import 'package:flutter/material.dart';
import 'login_page.dart';

class DashboardUser extends StatelessWidget {
  const DashboardUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Petugas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Halo, Petugas! 👷",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
