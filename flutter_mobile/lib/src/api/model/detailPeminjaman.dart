class DetailPeminjaman {
  String? nama_barang,
      merk_type,
      kode_barang,
      nup,
      nama_kegiatan,
      keterangan,
      nama_user;

  int? id;

  DetailPeminjaman(
      {this.id,
      this.nama_barang,
      this.kode_barang,
      this.merk_type,
      this.nup,
      this.nama_kegiatan,
      this.nama_user,
      this.keterangan});

  factory DetailPeminjaman.fromJson(Map<String, dynamic> json) {
    return DetailPeminjaman(
      id: json['id'],
      nama_barang: json['inventori']['nama_barang'],
      kode_barang: json['inventori']['kode_barang'],
      merk_type: json['inventori']['merk_type'],
      nup: json['inventori']['nup'],
      nama_user: json['user']['name'],
      nama_kegiatan: json['nama_kegiatan'],
      keterangan: json['keterangan'],
    );
  }
}
