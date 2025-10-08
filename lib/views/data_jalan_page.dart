import 'package:flutter/material.dart';
import '../models/road_data.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_sidebar.dart';

class DataJalanPage extends StatefulWidget {
  const DataJalanPage({super.key});

  @override
  State<DataJalanPage> createState() => _DataJalanPageState();
}

class _DataJalanPageState extends State<DataJalanPage> {
  final List<RoadData> dataJalan = [
    RoadData(
      no: 1,
      namaJalan: "Jl. Maospati - Barat",
      jenisKerusakan: "Berlubang",
      detail: "Panjang 15m, kedalaman lubang ±30cm, perlu penambalan segera.",
    ),
    RoadData(
      no: 2,
      namaJalan: "Jl. Gorang-gareng - Lembeyan",
      jenisKerusakan: "Berlubang",
      detail: "Kerusakan sepanjang 10m, lubang kecil namun banyak.",
    ),
    RoadData(
      no: 3,
      namaJalan: "Jl. Sarangan",
      jenisKerusakan: "Gelombang",
      detail: "Jalan bergelombang sepanjang 50m, membahayakan pengendara motor.",
    ),
    RoadData(
      no: 4,
      namaJalan: "Jl. Plaosan",
      jenisKerusakan: "Retak",
      detail: "Retakan aspal sepanjang 20m, risiko diperparah air hujan.",
    ),
  ];

  List<RoadData> filteredData = [];
  String selectedMenu = "Data Jalan";

  @override
  void initState() {
    super.initState();
    filteredData = dataJalan;
  }

  void _updateStatus(int index, String status) {
    setState(() {
      filteredData[index].setStatus = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(
          "Data jalan '${filteredData[index].getNamaJalan}' diubah ke $status",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Disetujui":
        return Colors.green;
      case "Ditolak":
        return Colors.red;
      case "Ditinjau":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // ✅ Desktop Layout
            if (constraints.maxWidth > 1024) {
              return Row(
                children: [
                  // 🔹 Sidebar di kiri
                  CustomSidebar(
                    selectedMenu: selectedMenu,
                    onSelect: (menu) {
                      setState(() => selectedMenu = menu);
                    },
                  ),

                  // 🔹 Area utama (navbar + konten)
                  Expanded(
                    child: Column(
                      children: [
                        // 🔹 Navbar di atas
                        CustomNavbar(
                          username: "Admin",
                          notificationCount: 3,
                          searchData:
                              dataJalan.map((e) => e.namaJalan).toList(),
                          onSearch: (query) {
                            setState(() {
                              filteredData = dataJalan.where((jalan) {
                                return jalan.getNamaJalan
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    jalan.getJenisKerusakan
                                        .toLowerCase()
                                        .contains(query.toLowerCase());
                              }).toList();
                            });
                          },
                        ),

                        // 🔹 Konten utama
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: _buildContent(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            // ✅ Mobile Layout
            else {
              return Column(
                children: [
                  CustomNavbar(
                    username: "Admin",
                    notificationCount: 3,
                    searchData:
                        dataJalan.map((e) => e.namaJalan).toList(),
                    onSearch: (query) {
                      setState(() {
                        filteredData = dataJalan.where((jalan) {
                          return jalan.getNamaJalan
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              jalan.getJenisKerusakan
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                        }).toList();
                      });
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: _buildContent(context),
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

  // 🔹 Konten utama Data Jalan
  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Jalan Rusak",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // 🔹 Tabel Data Jalan
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFFFA726).withOpacity(0.2)),
              columnSpacing: 24,
              border: TableBorder.all(color: Colors.grey.withOpacity(0.3)),
              columns: const [
                DataColumn(
                    label: Text("No.",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text("Nama Jalan",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text("Jenis Kerusakan",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text("Status",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text("Aksi",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ],
              rows: List.generate(filteredData.length, (index) {
                final jalan = filteredData[index];
                return DataRow(cells: [
                  DataCell(Text(jalan.no.toString(),
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(jalan.getNamaJalan,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(jalan.getJenisKerusakan,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(
                    jalan.getStatus,
                    style: TextStyle(
                      color: _getStatusColor(jalan.getStatus),
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.info, color: Colors.orangeAccent),
                      onPressed: () => _showDetailBottomSheet(context, jalan, index),
                    ),
                  ),
                ]);
              }),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 BottomSheet Detail Jalan
  void _showDetailBottomSheet(BuildContext context, RoadData jalan, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 60,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                jalan.getNamaJalan,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 8),
              Text("Jenis Kerusakan: ${jalan.getJenisKerusakan}",
                  style: const TextStyle(color: Colors.white)),
              Text("Status: ${jalan.getStatus}",
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              Text("Detail: ${jalan.getDetail}",
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text("Setujui"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      Navigator.pop(context);
                      _updateStatus(index, "Disetujui");
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text("Tolak"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                      _updateStatus(index, "Ditolak");
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.visibility, color: Colors.white),
                    label: const Text("Tinjau"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.pop(context);
                      _updateStatus(index, "Ditinjau");
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}