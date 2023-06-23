class GedungRuangan {
  String? nama_gedung, nama_ruangan, id_ruangan;

  int? id_gedung;

  GedungRuangan({
    this.id_gedung,
    this.nama_gedung,
    this.id_ruangan,
    this.nama_ruangan,
  });

  factory GedungRuangan.fromJson(Map<String, dynamic> json) {
    return GedungRuangan(
      id_gedung: json['id_gedung'],
      nama_gedung: json['gedung'],
      id_ruangan: json['ruangan']['id_ruangan'],
      nama_ruangan: json['ruangan']['ruangan'],
    );
  }
}
