class PersetujuanPeminjaman {
  String? status_persetujuan, kode_peminjaman;

  int? id;

  PersetujuanPeminjaman({
    this.id,
    this.kode_peminjaman,
    // this.status_persetujuan,
  });

  factory PersetujuanPeminjaman.fromJson(Map<String, dynamic> json) {
    return PersetujuanPeminjaman(
      id: json['id'],
      kode_peminjaman: json['kode_peminjaman'],
      // status_persetujuan: json['status_persetujuan'],
    );
  }
}
