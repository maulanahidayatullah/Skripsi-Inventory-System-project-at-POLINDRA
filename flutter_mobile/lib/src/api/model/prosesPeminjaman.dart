class ProsesPeminjaman {
  String? kode_peminjaman, tgl_kembali;

  int? id;

  ProsesPeminjaman({
    this.id,
    this.kode_peminjaman,
    this.tgl_kembali,
  });

  factory ProsesPeminjaman.fromJson(Map<String, dynamic> json) {
    return ProsesPeminjaman(
      id: json['id'],
      kode_peminjaman: json['kode_peminjaman'],
      tgl_kembali: json['tgl_kembali'],
    );
  }
}
