import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_mobile/src/Widget/menu.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_mobile/src/api/api.dart';

class SelesaiPeminjamanPage extends StatefulWidget {
  const SelesaiPeminjamanPage({Key? key}) : super(key: key);

  @override
  State<SelesaiPeminjamanPage> createState() => _SelesaiPeminjamanPageState();
}

class _SelesaiPeminjamanPageState extends State<SelesaiPeminjamanPage> {
  String unitKerja = '';
  String namaKegiatan = '';
  String keterangan = '';
  String tglKembali = '';
  String jamKembali = '';
  var txUnitKerja = TextEditingController();
  var txNamaKegiatan = TextEditingController();
  var txKeterangan = TextEditingController();
  var txTglKembali = TextEditingController();
  var txJamKembali = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 70,
        title: Text('Tambah Peminjaman'), backgroundColor: Colors.green,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Tambah Peminjaman",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: txUnitKerja,
                    decoration: InputDecoration(
                      labelText: "Unit Kerja",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nama tidak boleh Kosong";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      unitKerja = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    // keyboardType: TextInputType.number,
                    controller: txNamaKegiatan,
                    decoration: InputDecoration(
                      labelText: "Nama Kegiatan",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Umur tidak boleh Kosong";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      namaKegiatan = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    // keyboardType: TextInputType.number,
                    controller: txKeterangan,
                    decoration: InputDecoration(
                      labelText: "Keterangan",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "No HP tidak boleh Kosong";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      keterangan = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: txTglKembali,
                    decoration: InputDecoration(
                      labelText: "Tanggal Kembali",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Alamat tidak boleh Kosong";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      tglKembali = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: txJamKembali,
                    decoration: InputDecoration(
                      labelText: "Jam Kembali",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pekerjaan tidak boleh Kosong";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      jamKembali = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      cek_inputan();
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TipeSDQ(login: false, nama: txNama.text.toString(), umur: txUmur.text.toString(), instansi: txInstansi.text.toString(),)));
                    },
                    child: Text(
                      "Pinjam",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cek_inputan() {
    if (unitKerja == '') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        title: 'Unit Kerja Tidak Boleh Kosong !',
        btnOkOnPress: () {},
        onDismissCallback: (type) {
          // progressDialog.dismiss();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else if (namaKegiatan == '') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        title: 'Nama Kegiatan Tidak Boleh Kosong !',
        btnOkOnPress: () {},
        onDismissCallback: (type) {
          // progressDialog.dismiss();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else if (keterangan == '') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        title: 'Keterangan Tidak Boleh Kosong !',
        btnOkOnPress: () {},
        onDismissCallback: (type) {
          // progressDialog.dismiss();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else if (tglKembali == '') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        title: 'Tanggal Kembali Tidak Boleh Kosong !',
        btnOkOnPress: () {},
        onDismissCallback: (type) {
          // progressDialog.dismiss();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else if (jamKembali == '') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        title: 'Jam Kembali Tidak Boleh Kosong !',
        btnOkOnPress: () {},
        onDismissCallback: (type) {
          // progressDialog.dismiss();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    } else {
      ProgressDialog progressDialog = ProgressDialog(
        context,
        blur: 10,
        message: Text("Mohon Tunggu..."),
      );
      progressDialog.show();
      try {
        API
            .tambahPeminjaman(
                unitKerja, namaKegiatan, keterangan, tglKembali, jamKembali)
            .then((value) async {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Peminjaman ditambahkan, Silahkan menunggu persetujuan',
            btnOkOnPress: () {},
            onDismissCallback: (type) {
              progressDialog.dismiss();

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Menu()));
            },
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.blue,
          ).show();
        });
      } catch (e) {}
    }
  }
}
