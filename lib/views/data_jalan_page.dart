import 'package:flutter/material.dart';
import '../models/road_data.dart';
import 'login_page.dart';
import 'dashboard_admin.dart';

class DataJalanPage extends StatefulWidget {
  const DataJalanPage({super.key});

  @override
  State<DataJalanPage> createState() => _DataJalanPageState();
}

class _DataJalanPageState extends State<DataJalanPage> {
  final TextEditingController _searchController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    filteredData = dataJalan;
    _searchController.addListener(_filterData);
  }

  void _filterData() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredData = dataJalan.where((jalan) {
        return jalan.getNamaJalan.toLowerCase().contains(query) ||
            jalan.getJenisKerusakan.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _updateStatus(int index, String status) {
    setState(() {
      filteredData[index].setStatus = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data jalan '${filteredData[index].getNamaJalan}' diubah ke $status")),
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
      // ✅ Drawer sama dengan DashboardAdmin
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
              child: Text("Dash UI", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardAdmin(username: "Admin")), // bisa diganti username login
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.traffic),
              title: const Text("Data Jalan"),
              onTap: () => Navigator.pop(context), // tetap di halaman ini
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

      // ✅ AppBar dengan gradient seperti DashboardAdmin
      appBar: AppBar(
        title: const Text("Data Jalan"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF512F), Color(0xFFF09819)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔎 Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari jalan atau jenis kerusakan...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Card supaya tabel rapi
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.deepPurple.shade100),
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columns: const [
                      DataColumn(label: Text("NO.")),
                      DataColumn(label: Text("Nama Jalan")),
                      DataColumn(label: Text("Jenis Kerusakan")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Action")),
                    ],
                    rows: List.generate(filteredData.length, (index) {
                      final jalan = filteredData[index];
                      return DataRow(cells: [
                        DataCell(Text(jalan.no.toString())),
                        DataCell(Text(jalan.getNamaJalan)),
                        DataCell(Text(jalan.getJenisKerusakan)),
                        DataCell(
                          Text(
                            jalan.getStatus,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(jalan.getStatus),
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.info, color: Colors.blue),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                builder: (_) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          jalan.getNamaJalan,
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text("Jenis Kerusakan: ${jalan.getJenisKerusakan}"),
                                        Text("Status: ${jalan.getStatus}"),
                                        const SizedBox(height: 6),
                                        Text("Detail: ${jalan.getDetail}"),
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
                            },
                          ),
                        ),
                      ]);
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
