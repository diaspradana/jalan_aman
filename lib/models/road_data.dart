class RoadData {
  final int no;
  String namaJalan;
  String jenisKerusakan;
  String detail;
  String status;

  RoadData({
    required this.no,
    required this.namaJalan,
    required this.jenisKerusakan,
    this.detail = "",
    this.status = "Belum Ditinjau",
  });

  // ✅ Encapsulation (getter & setter)
  String get getNamaJalan => namaJalan;
  String get getJenisKerusakan => jenisKerusakan;
  String get getDetail => detail;
  String get getStatus => status;

  set setNamaJalan(String value) => namaJalan = value;
  set setJenisKerusakan(String value) => jenisKerusakan = value;
  set setStatus(String value) => status = value;
}

/// ✅ Inheritance
class JalanUtama extends RoadData {
  JalanUtama({
    required int no,
    required String namaJalan,
    required String jenisKerusakan,
    String detail = "",
    String status = "Belum Ditinjau",
  }) : super(
          no: no,
          namaJalan: namaJalan,
          jenisKerusakan: jenisKerusakan,
          detail: detail,
          status: status,
        );

  // ✅ Polymorphism (override)
  @override
  String get getJenisKerusakan => "KERUSAKAN SERIUS: $jenisKerusakan";
}
