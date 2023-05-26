class Mobilitas {
  String? user, nama_barang, merk_type, gedung, ruangan;

  int? id, kode_barang;

  bool? success;

  Mobilitas(
      {this.id,
      this.success,
      this.user,
      this.kode_barang,
      this.nama_barang,
      this.merk_type,
      this.gedung,
      this.ruangan});

  factory Mobilitas.fromJson(Map<String, dynamic> json) {
    return Mobilitas(
        id: json['id'],
        success: json['success'],
        user: json['user']['pegawai']['nama'],
        kode_barang: json['inventori']['kode_barang'],
        nama_barang: json['inventori']['nama_barang'],
        merk_type: json['inventori']['merk_type'],
        gedung: json['gedung']['gedung'],
        ruangan: json['ruangan']['ruangan']);
  }
}
