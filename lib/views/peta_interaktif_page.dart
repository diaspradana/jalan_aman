import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

// 🔹 Import widget yang sudah kamu buat
import '../widgets/custom_navbar.dart';
import '../widgets/custom_sidebar.dart';

class PetaInteraktifPage extends StatefulWidget {
  const PetaInteraktifPage({super.key});

  @override
  State<PetaInteraktifPage> createState() => _PetaInteraktifPageState();
}

class _PetaInteraktifPageState extends State<PetaInteraktifPage> {
  final PopupController _popupController = PopupController();

  final List<Marker> markers = [
    Marker(
      point: LatLng(-7.6542, 111.3325),
      width: 40,
      height: 40,
      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
    ),
    Marker(
      point: LatLng(-7.6670, 111.3380),
      width: 40,
      height: 40,
      child: const Icon(Icons.location_pin, color: Colors.orange, size: 40),
    ),
  ];

  final List<Map<String, String>> infoKerusakan = [
    {
      "nama": "Jl. Raya Sarangan",
      "jenis": "Lubang besar",
      "status": "Belum diperbaiki"
    },
    {
      "nama": "Jl. Maospati - Barat",
      "jenis": "Aspal retak",
      "status": "Sudah diperbaiki"
    },
  ];

  String selectedMenu = "Peta Interaktif";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 🔹 Desktop layout
            if (constraints.maxWidth > 1024) {
              return Row(
                children: [
                  // 🔹 Sidebar kiri
                  CustomSidebar(
                    selectedMenu: selectedMenu,
                    onSelect: (menu) {
                      setState(() => selectedMenu = menu);
                    },
                  ),

                  // 🔹 Area utama
                  Expanded(
                    child: Column(
                      children: [
                        // 🔹 Navbar atas
                        CustomNavbar(
                          username: "Admin",
                          notificationCount: 2,
                          searchData: infoKerusakan.map((e) => e["nama"]!).toList(),
                          onSearch: (query) {
                            // Fitur pencarian di navbar (jika mau aktifkan nanti)
                          },
                        ),

                        // 🔹 Konten utama: peta interaktif
                        Expanded(child: _buildMapView(context)),
                      ],
                    ),
                  ),
                ],
              );
            }

            // 🔹 Layout mobile
            else {
              return Column(
                children: [
                  CustomNavbar(
                    username: "Admin",
                    notificationCount: 2,
                    searchData: infoKerusakan.map((e) => e["nama"]!).toList(),
                    onSearch: (query) {},
                  ),
                  Expanded(child: _buildMapView(context)),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // 🔸 Widget Peta Interaktif
  Widget _buildMapView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-7.6542, 111.3325),
            initialZoom: 13,
            onTap: (_, __) => _popupController.hideAllPopups(),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            PopupMarkerLayerWidget(
              options: PopupMarkerLayerOptions(
                popupController: _popupController,
                markers: markers,
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    final index = markers.indexOf(marker);
                    final info = infoKerusakan[index];
                    return Card(
                      color: const Color(0xFF1A1A2E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(info["nama"]!,
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text("Jenis: ${info["jenis"]!}",
                                style: const TextStyle(color: Colors.white)),
                            Text("Status: ${info["status"]!}",
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
