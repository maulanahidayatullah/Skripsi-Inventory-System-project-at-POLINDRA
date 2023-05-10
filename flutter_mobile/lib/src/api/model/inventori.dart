class Inventori {
  String? merk, tahun, nama_barang, qr, pelabelan, kondisi, keterangan;
  int? id,
      qty,
      harga,
      nup,
      kode_barang,
      nilai_bmn,
      jurusan_id,
      gedung_id,
      ruangan_id;

  bool? success;

  Inventori(
      {this.id,
      this.merk,
      this.tahun,
      this.nama_barang,
      this.qr,
      this.pelabelan,
      this.kondisi,
      this.keterangan,
      this.qty,
      this.harga,
      this.nup,
      this.kode_barang,
      this.nilai_bmn,
      this.jurusan_id,
      this.gedung_id,
      this.ruangan_id,
      this.success});
}
