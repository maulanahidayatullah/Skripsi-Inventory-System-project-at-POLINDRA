import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/pages/peminjaman/keranjangPeminjamanPage.dart';
import 'package:flutter_mobile/src/api/model/inventori.dart';
import 'package:flutter_mobile/src/pages/peminjaman/persetujuanPage.dart';
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
            Container(
              color: Color.fromRGBO(243, 245, 248, 1),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersetujuanPage()),
                      );
                    },
                    child: Container(
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
                                "Pol-P-2-230810",
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
                                "Belum Disetujui",
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
                  );
                },
                shrinkWrap: true,
                itemCount: 2,
                padding: EdgeInsets.all(0),
                controller: ScrollController(keepScrollOffset: false),
              ),
            ),
            Container(
              color: Color.fromRGBO(243, 245, 248, 1),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
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
                              "Pol-P-2-230810",
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
                              "2023-06-23 12:00",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: 1,
                padding: EdgeInsets.all(0),
                controller: ScrollController(keepScrollOffset: false),
              ),
            ),
            Container(
              color: Color.fromRGBO(243, 245, 248, 1),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
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
                              "Pol-P-2-230810",
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
                              "Selesai",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: 2,
                padding: EdgeInsets.all(0),
                controller: ScrollController(keepScrollOffset: false),
              ),
            ),
          ],
        ),
      ),
    );

    Widget _card() {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
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
                      "Lemari",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[900]),
                    ),
                    Text(
                      "09-04-2023",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
                // ),
                // Expanded(
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Icon(
                    Icons.date_range,
                    color: Colors.green[900],
                  ),
                  padding: EdgeInsets.all(12),
                ),
                Spacer(),
                // ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "+\$500.5",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightGreen),
                      ),
                      Text(
                        "26 Jan",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        shrinkWrap: true,
        itemCount: 2,
        padding: EdgeInsets.all(0),
        controller: ScrollController(keepScrollOffset: false),
      );
    }
  }
}
