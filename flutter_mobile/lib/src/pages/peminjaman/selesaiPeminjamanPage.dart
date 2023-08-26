import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_mobile/src/Widget/menu.dart';
import 'package:flutter_mobile/src/pages/peminjamanPage.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelesaiPeminjamanPage extends StatefulWidget {
  const SelesaiPeminjamanPage({Key? key}) : super(key: key);

  @override
  State<SelesaiPeminjamanPage> createState() => _SelesaiPeminjamanPageState();
}

class _SelesaiPeminjamanPageState extends State<SelesaiPeminjamanPage> {
  DateTime tglKembali = DateTime.now();
  TimeOfDay jamKembali = TimeOfDay.now();

  String unitKerja = '';
  String namaKegiatan = '';
  String keterangan = '';
  String strTglKembali = '';
  String strJamKembali = '';
  var txUnitKerja = TextEditingController();
  var txNamaKegiatan = TextEditingController();
  var txKeterangan = TextEditingController();
  var txTglKembali = TextEditingController(text: '');
  var txJamKembali = TextEditingController(text: '');
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
                    readOnly: true,
                    showCursor: true,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      ).then((value) {
                        setState(() {
                          tglKembali = value!;
                          txTglKembali.text = tglKembali.day.toString() +
                              '-' +
                              tglKembali.month.toString() +
                              '-' +
                              tglKembali.year.toString();
                        });
                        strTglKembali = tglKembali.year.toString() +
                            '-' +
                            tglKembali.month.toString() +
                            '-' +
                            tglKembali.day.toString();
                      });
                    },
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: txJamKembali,
                    readOnly: true,
                    showCursor: true,
                    onTap: () async {
                      final TimeOfDay? waktuPilih = await showTimePicker(
                          context: context,
                          initialTime: jamKembali,
                          initialEntryMode: TimePickerEntryMode.dial);
                      if (waktuPilih != null) {
                        setState(() {
                          jamKembali = waktuPilih;
                          txJamKembali.text = jamKembali.hour.toString() +
                              ':' +
                              jamKembali.minute.toString();

                          strJamKembali = jamKembali.hour.toString() +
                              ':' +
                              jamKembali.minute.toString();
                        });
                      }
                    },
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
            .tambahPeminjaman(unitKerja, namaKegiatan, keterangan,
                strTglKembali, strJamKembali)
            .then((value) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var level = prefs.getString('level');
          if (level == 'user_5') {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              headerAnimationLoop: true,
              title: 'Peminjaman Ditambahkan',
              btnOkOnPress: () {},
              onDismissCallback: (type) {
                progressDialog.dismiss();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => peminjamanPage()),
                    (route) => false);
              },
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.blue,
            ).show();
          } else {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              headerAnimationLoop: true,
              title: 'Peminjaman ditambahkan, Harap menunggu persetujuan',
              btnOkOnPress: () {},
              onDismissCallback: (type) {
                progressDialog.dismiss();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => peminjamanPage()),
                    (route) => false);
              },
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.blue,
            ).show();
          }
        });
      } catch (e) {}
    }
  }
}
