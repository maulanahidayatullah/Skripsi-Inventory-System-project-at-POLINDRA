import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/api/model/detailPeminjaman.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/model/keranjangPeminjaman.dart';
import 'package:ndialog/ndialog.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_mobile/src/Widget/menu.dart';

class DetailPeminjamanPage extends StatefulWidget {
  final String? kode_peminjaman;

  const DetailPeminjamanPage({super.key, required this.kode_peminjaman});

  @override
  State<DetailPeminjamanPage> createState() => _DetailPeminjamanPageState();
}

class _DetailPeminjamanPageState extends State<DetailPeminjamanPage> {
  List<DetailPeminjaman> listPeminjaman = [];
  API api = API();
  String? level = '';

  Future<String?> getLevel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString('level'));
    level = prefs.getString('level')!;
  }

  getDataKeranjang() async {
    listPeminjaman =
        await api.getDetailPeminjaman(context, widget.kode_peminjaman);
    setState(() {});
  }

  @override
  void initState() {
    getDataKeranjang();
    getLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listPeminjaman.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Persetujuan Peminjaman'),
          backgroundColor: Colors.green,
        ),
        body: Container(child: Text("Laka data")),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detail Peminjaman'),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: <Widget>[
                  // Expanded(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.kode_peminjaman.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.green),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Peminjam : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        listPeminjaman[0].nama_user.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.green),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nama Kegiatan : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        listPeminjaman[0].nama_kegiatan.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.green),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Keterangan : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        listPeminjaman[0].keterangan.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: listPeminjaman.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _card(
                          listPeminjaman[index].id,
                          listPeminjaman[index].kode_barang,
                          listPeminjaman[index].nama_barang,
                          listPeminjaman[index].merk_type,
                          listPeminjaman[index].nup,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // if (level == 'user_4') ...[
            //   InkWell(
            //     onTap: () async {
            //       ProgressDialog progressDialog = ProgressDialog(
            //         context,
            //         blur: 10,
            //         message: Text("Mohon Tunggu..."),
            //       );
            //       progressDialog.show();
            //       try {
            //         API
            //             .persetujuanPembimbing(widget.kode_peminjaman)
            //             .then((value) async {
            //           AwesomeDialog(
            //             context: context,
            //             dialogType: DialogType.success,
            //             animType: AnimType.scale,
            //             headerAnimationLoop: true,
            //             title: 'Berhasil DiSetujui',
            //             btnOkOnPress: () {},
            //             onDismissCallback: (type) {
            //               progressDialog.dismiss();

            //               Navigator.push(context,
            //                   MaterialPageRoute(builder: (context) => Menu()));
            //             },
            //             btnOkIcon: Icons.cancel,
            //             btnOkColor: Colors.blue,
            //           ).show();
            //         });
            //       } catch (e) {}
            //     },
            //     child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //       padding: EdgeInsets.symmetric(vertical: 15),
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(5)),
            //           boxShadow: <BoxShadow>[
            //             BoxShadow(
            //                 color: Colors.grey.shade200,
            //                 offset: Offset(2, 4),
            //                 blurRadius: 5,
            //                 spreadRadius: 2)
            //           ],
            //           gradient: LinearGradient(
            //               begin: Alignment.centerLeft,
            //               end: Alignment.centerRight,
            //               colors: [Color(0xff85a7c7), Color(0xff4d87b7)])),
            //       child: Text(
            //         'Setujui',
            //         style: TextStyle(fontSize: 20, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ] else if (level == 'user_5') ...[
            InkWell(
              onTap: () async {
                // ProgressDialog progressDialog = ProgressDialog(
                //   context,
                //   blur: 10,
                //   message: Text("Mohon Tunggu..."),
                // );
                // progressDialog.show();
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.scale,
                  headerAnimationLoop: true,
                  title: 'Berhasil Di Setujui',
                  btnOkOnPress: () {},
                  onDismissCallback: (type) {
                    // progressDialog.dismiss();

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Menu()));
                  },
                  btnOkIcon: Icons.cancel,
                  btnOkColor: Colors.blue,
                ).show();
                // try {
                //   API
                //       .persetujuanWadir(widget.kode_peminjaman)
                //       .then((value) async {
                //     AwesomeDialog(
                //       context: context,
                //       dialogType: DialogType.success,
                //       animType: AnimType.scale,
                //       headerAnimationLoop: true,
                //       title: 'Berhasil DiSetujui',
                //       btnOkOnPress: () {},
                //       onDismissCallback: (type) {
                //         progressDialog.dismiss();

                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => Menu()));
                //       },
                //       btnOkIcon: Icons.cancel,
                //       btnOkColor: Colors.blue,
                //     ).show();
                //   });
                // } catch (e) {}
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xff85a7c7), Color(0xff4d87b7)])),
                child: Text(
                  'Setujui',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            // ] else
            // ...[],
            SizedBox(
              height: 75,
            )
          ],
        ),
      );
    }
  }

  Widget _card(int? id, String? kode_barang, String? nama_barang,
      String? merk_type, String? nup) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          color: Color(0xff4d87b7),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10))),
                margin: EdgeInsets.only(
                  left: 10,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nama_barang.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(merk_type.toString(), style: TextStyle(fontSize: 16)),
                    // Text("Kode Barang & NUP : ",
                    //     style: TextStyle(
                    //         fontSize: 20, fontWeight: FontWeight.bold)),
                    // Text(kode_barang.toString() + nup.toString(),
                    //     style: TextStyle(fontSize: 20)),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
