import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/model/persetujuanPeminjaman.dart';
import 'package:flutter_mobile/src/api/model/prosesPeminjaman.dart';
import 'package:flutter_mobile/src/api/model/riwayatPeminjaman.dart';
import 'package:flutter_mobile/src/pages/peminjaman/keranjangPeminjamanPage.dart';
import 'package:flutter_mobile/src/api/model/inventori.dart';
import 'package:flutter_mobile/src/pages/peminjaman/detailPeminjamanPage.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:flutter_mobile/src/api/api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ndialog/ndialog.dart';

class peminjamanPage extends StatefulWidget {
  const peminjamanPage({super.key});

  @override
  State<peminjamanPage> createState() => _peminjamanPageState();
}

class _peminjamanPageState extends State<peminjamanPage> {
  Inventori inventori = new Inventori();
  List<PersetujuanPeminjaman> listPersetujuan = [];
  List<ProsesPeminjaman> listProses = [];
  List<RiwayatPeminjaman> listRiwayat = [];
  API api = API();

  getDataPersetujuan() async {
    listPersetujuan = await api.getPersetujuanPeminjaman(context);
    setState(() {});
  }

  getDataProses() async {
    listProses = await api.getProsesPeminjaman(context);
    setState(() {});
  }

  getDataRiwayat() async {
    listRiwayat = await api.getRiwayatPeminjaman(context);
    setState(() {});
  }

  @override
  void initState() {
    getDataPersetujuan();
    getDataProses();
    getDataRiwayat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          toolbarHeight: 250,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  "Persetujuan",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  "Proses",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  "Riwayat",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          title: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Peminjaman",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(
                  "Inventory Polindra",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.green[100]),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    try {
                      API.cekKeranjangPeminjaman(context).then((value) async {
                        if (value == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const KeranjangPeminjamanPage()),
                          );
                        } else {
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
                                API.cekInventori(nup).then((value) {
                                  setState(() {
                                    inventori = value;
                                    if (inventori.success == true) {
                                      try {
                                        API
                                            .tambahKeranjangPeminjaman(
                                                inventori.nup)
                                            .then((value) async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const KeranjangPeminjamanPage()),
                                          );
                                        });
                                      } catch (e) {}
                                      progressDialog.dismiss();
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.scale,
                                        headerAnimationLoop: true,
                                        title:
                                            'Mohon Maaf .. Barang tidak ditemukan',
                                        btnOkOnPress: () {},
                                        onDismissCallback: (type) {
                                          progressDialog.dismiss();
                                        },
                                        btnOkIcon: Icons.cancel,
                                        btnOkColor: Colors.blue,
                                      ).show();
                                    }
                                  });
                                });
                              } catch (e) {
                                API.gagal(context, progressDialog);
                              }
                            });
                          }
                        }
                      });
                    } catch (e) {
                      // API.gagal(context, pDialog)
                    }
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 245, 248, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.green,
                            size: 35,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Tambah Peminjaman",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            if (listPersetujuan.isEmpty) ...[
              Container(
                child: Center(
                  child: Text(
                    'Tidak Ada Data',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green[300]),
                  ),
                ),
              )
            ] else ...[
              Container(
                color: Color.fromRGBO(243, 245, 248, 1),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: listPersetujuan.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                              child: InkWell(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            listPersetujuan[index]
                                                .kode_peminjaman
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green[500]),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Nama Kegiatan : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey[600]),
                                          ),
                                          Text(
                                            'Belum di setujui',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPeminjamanPage(
                                    kode_peminjaman:
                                        listPersetujuan[index].kode_peminjaman,
                                  ),
                                ),
                              );
                            },
                          ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ],
            if (listProses.isEmpty) ...[
              Container(
                child: Center(
                  child: Text(
                    'Tidak Ada Data',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green[300]),
                  ),
                ),
              )
            ] else ...[
              Container(
                color: Color.fromRGBO(243, 245, 248, 1),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: listProses.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            listProses[index]
                                                .kode_peminjaman
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green[500]),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Harap Dikembalikan Pada : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey[600]),
                                          ),
                                          Text(
                                            listProses[index]
                                                .tgl_kembali
                                                .toString(),
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
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ],
            if (listRiwayat.isEmpty) ...[
              Container(
                child: Center(
                  child: Text(
                    'Tidak Ada Data',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green[300]),
                  ),
                ),
              )
            ] else ...[
              Container(
                color: Color.fromRGBO(243, 245, 248, 1),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: listRiwayat.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            listRiwayat[index]
                                                .kode_peminjaman
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green[500]),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Status Peminjaman : ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey[600]),
                                          ),
                                          Text(
                                            'Selesai',
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
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
