class RiwayatPeminjaman {
  String? status_peminjaman, kode_peminjaman;

  int? id;

  RiwayatPeminjaman({
    this.id,
    this.kode_peminjaman,
    this.status_peminjaman,
  });

  factory RiwayatPeminjaman.fromJson(Map<String, dynamic> json) {
    return RiwayatPeminjaman(
      id: json['id'],
      kode_peminjaman: json['kode_peminjaman'],
      status_peminjaman: json['selesai'],
    );
  }
}
