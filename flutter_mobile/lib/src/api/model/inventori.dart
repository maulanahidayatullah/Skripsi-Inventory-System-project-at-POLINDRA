class Inventori {
  String? uraian_akun,
      nama_barang,
      tahun_perolehan,
      merk_type,
      kondisi_barang,
      keberadaan_barang,
      pelabelan_kodefikasi,
      pegawai,
      gedung,
      ruangan,
      status_psp,
      nama_sub_satker,
      nup,
      kode_barang,
      keterangan;
  int? id, kuantitas, nilai_bmn;

  bool? success;

  Inventori(
      {this.id,
      this.kode_barang,
      this.nup,
      this.kuantitas,
      this.nilai_bmn,
      this.uraian_akun,
      this.nama_barang,
      this.tahun_perolehan,
      this.merk_type,
      this.kondisi_barang,
      this.keberadaan_barang,
      this.pelabelan_kodefikasi,
      this.pegawai,
      this.gedung,
      this.ruangan,
      this.status_psp,
      this.nama_sub_satker,
      this.keterangan,
      this.success});
}
