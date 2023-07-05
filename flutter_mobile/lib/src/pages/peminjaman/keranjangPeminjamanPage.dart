import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/api.dart';
import '../../api/model/keranjangPeminjaman.dart';
import 'package:ndialog/ndialog.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:awesome_dialog/awesome_dialog.dart';

class KeranjangPeminjamanPage extends StatefulWidget {
  const KeranjangPeminjamanPage({super.key});

  @override
  State<KeranjangPeminjamanPage> createState() =>
      _KeranjangPeminjamanPageState();
}

class _KeranjangPeminjamanPageState extends State<KeranjangPeminjamanPage> {
  List<KeranjangPeminjaman> listKeranjang = [];
  API api = API();

  String _unit_kerja = '';
  String _nama_kegiatan = '';
  String _jumlah = '';
  String _satuan = '';
  String _keterangan = '';
  String _tgl_kembali = '';
  String _jam_kembali = '';

  var txUnitKerja = TextEditingController();
  var txNamaKegiatan = TextEditingController();
  var txJumlah = TextEditingController();
  var txSatuan = TextEditingController();
  var txKeterangan = TextEditingController();
  var txTglKembali = TextEditingController();
  var txJamKembali = TextEditingController();

  getDataKeranjang() async {
    listKeranjang = await api.getKeranjangPeminjaman(context);
    setState(() {});
  }

  @override
  void initState() {
    getDataKeranjang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listKeranjang.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Keranjang Peminjaman'),
          actions: <Widget>[
            IconButton(
              padding: new EdgeInsets.only(right: 10),
              icon: const Icon(
                Icons.add_circle,
                size: 35,
              ),
              onPressed: () async {
                String? nup = await Scanner.scan();
                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  blur: 10,
                  message: Text("Mohon Tunggu..."),
                );
                progressDialog.show();
                if (nup != null) {
                  setState(() {
                    try {
                      API.tambahKeranjangPeminjaman(nup).then((value) async {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.scale,
                          headerAnimationLoop: true,
                          title: value,
                          btnOkOnPress: () {},
                          onDismissCallback: (type) {
                            progressDialog.dismiss();
                          },
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.blue,
                        ).show();
                        getDataKeranjang();
                      });
                    } catch (e) {}
                  });
                }
              },
            ),
          ],
          backgroundColor: Colors.green,
        ),
        body: Container(child: Text("Laka data")),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Keranjang Peminjaman'),
          actions: <Widget>[
            IconButton(
              padding: new EdgeInsets.only(right: 10),
              icon: const Icon(
                Icons.add_circle,
                size: 35,
              ),
              onPressed: () async {
                String? nup = await Scanner.scan();
                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  blur: 10,
                  message: Text("Mohon Tunggu..."),
                );
                progressDialog.show();
                if (nup != null) {
                  setState(() {
                    try {
                      API.tambahKeranjangPeminjaman(nup).then((value) async {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.scale,
                          headerAnimationLoop: true,
                          title: value,
                          btnOkOnPress: () {},
                          onDismissCallback: (type) {
                            progressDialog.dismiss();
                          },
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.blue,
                        ).show();
                        getDataKeranjang();
                      });
                    } catch (e) {}
                  });
                }
              },
            ),
          ],
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: listKeranjang.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _card(
                          listKeranjang[index].id,
                          listKeranjang[index].kode_barang,
                          listKeranjang[index].nama_barang,
                          listKeranjang[index].merk_type,
                          listKeranjang[index].nup,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () async {
                _cardModal();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
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
                  'Selesai',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 80,
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
        padding: const EdgeInsets.all(10.0),
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
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(merk_type.toString(), style: TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text("Kode Barang & NUP : ",
                    //     style: TextStyle(
                    //         fontSize: 20, fontWeight: FontWeight.bold)),
                    // Text(kode_barang.toString() + nup.toString(),
                    //     style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: SizedBox(
                          height: 10,
                        )),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ProgressDialog progressDialog = ProgressDialog(
                                context,
                                blur: 10,
                                message: Text("Mohon Tunggu..."),
                              );
                              progressDialog.show();
                              setState(() {
                                try {
                                  API.hapusMobilitas(id).then((value) async {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.scale,
                                      headerAnimationLoop: true,
                                      title: value,
                                      btnOkOnPress: () {},
                                      onDismissCallback: (type) {
                                        progressDialog.dismiss();
                                      },
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.blue,
                                    ).show();
                                    getDataKeranjang();
                                  });
                                } catch (e) {}
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Hapus",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget? _cardModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Silahkan isi Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Card(
                    //   color: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //       side: BorderSide(color: Colors.pink),
                    //       borderRadius: BorderRadius.circular(8)),
                    //   child: Padding(
                    //       padding: const EdgeInsets.all(15.0),
                    //       child: Text('asd')),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: txUnitKerja,
                        decoration: InputDecoration(
                          labelText: "Unit Kerja",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: BorderSide(color: Colors.orange)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _unit_kerja = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('asd')),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        // print(int.parse(gedung).runtimeType);
                        ProgressDialog progressDialog = ProgressDialog(
                          context,
                          blur: 10,
                          message: Text("Mohon Tunggu..."),
                        );
                        // listKeranjang.forEach((value) {
                        //   try {
                        //     API
                        //         .selesaiMobilitas(
                        //             value.id, gedung_id, ruangan_id)
                        //         .then((value) async {
                        //       AwesomeDialog(
                        //         context: context,
                        //         dialogType: DialogType.success,
                        //         animType: AnimType.scale,
                        //         headerAnimationLoop: true,
                        //         title: 'Mobilitas Barang berhasil',
                        //         btnOkOnPress: () {},
                        //         onDismissCallback: (type) {
                        //           progressDialog.dismiss();

                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => Menu()));
                        //         },
                        //         btnOkIcon: Icons.cancel,
                        //         btnOkColor: Colors.blue,
                        //       ).show();
                        //     });
                        //   } catch (e) {}
                        // });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                                colors: [
                                  Color(0xff85a7c7),
                                  Color(0xff4d87b7)
                                ])),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
