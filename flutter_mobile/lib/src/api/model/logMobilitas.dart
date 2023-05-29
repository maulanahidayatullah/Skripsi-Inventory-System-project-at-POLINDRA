class LogMobilitas {
  String? nama_barang,
      gedung_sebelum,
      ruangan_sebelum,
      gedung_sesudah,
      ruangan_sesudah,
      date;

  int? id;

  LogMobilitas(
      {this.id,
      this.nama_barang,
      this.gedung_sebelum,
      this.ruangan_sebelum,
      this.gedung_sesudah,
      this.ruangan_sesudah,
      this.date});

  factory LogMobilitas.fromJson(Map<String, dynamic> json) {
    return LogMobilitas(
        id: json['id'],
        nama_barang: json['mobilitas_sebelum']['inventori']['nama_barang'],
        gedung_sebelum: json['mobilitas_sebelum']['gedung']['gedung'],
        ruangan_sebelum: json['mobilitas_sebelum']['ruangan']['ruangan'],
        gedung_sesudah: json['mobilitas_sesudah']['gedung']['gedung'],
        ruangan_sesudah: json['mobilitas_sesudah']['ruangan']['ruangan'],
        date: json['date']);
  }
}
