class KeranjangPeminjaman {
  String? nama_barang, merk_type, kode_barang, nup;

  int? id;

  KeranjangPeminjaman({
    this.id,
    this.nama_barang,
    this.kode_barang,
    this.merk_type,
    this.nup,
  });

  factory KeranjangPeminjaman.fromJson(Map<String, dynamic> json) {
    return KeranjangPeminjaman(
      id: json['id'],
      nama_barang: json['inventori']['nama_barang'],
      kode_barang: json['inventori']['kode_barang'],
      merk_type: json['inventori']['merk_type'],
      nup: json['inventori']['nup'],
    );
  }
}
