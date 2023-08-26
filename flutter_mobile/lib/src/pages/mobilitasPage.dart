import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/api/model/inventori.dart';
import 'package:flutter_mobile/src/api/model/logMobilitas.dart';
import 'package:flutter_mobile/src/pages/mobilitas/dataMobilitas.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ndialog/ndialog.dart';

class MobilitasPage extends StatefulWidget {
  const MobilitasPage({super.key});

  @override
  State<MobilitasPage> createState() => _MobilitasPageState();
}

class _MobilitasPageState extends State<MobilitasPage> {
  Inventori inventori = Inventori();

  List<LogMobilitas> logMobilitas = [];
  API api = API();

  getLogMobilitas() async {
    logMobilitas = await api.getLogMobilitas(context);
    setState(() {});
  }

  @override
  void initState() {
    // http.getSemester_1();
    getLogMobilitas();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          //Container for top data
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Mobilitas",
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
                      color: Colors.pink[100]),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    try {
                      API.cekMobilitas(context).then((value) async {
                        if (value == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DataMobilitas()),
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
                                            .tambahMobilitas(inventori.nup)
                                            .then((value) async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DataMobilitas()),
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
                            color: Colors.pink,
                            size: 35,
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Tambah Mobilitas",
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

          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Riwayat Mobilitas",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      if (logMobilitas.isEmpty) ...[
                        SizedBox(
                          height: 150,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              'Tidak Ada Data',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black12),
                            ),
                          ),
                        )
                      ] else ...[
                        ListView.builder(
                          itemCount: logMobilitas.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  _card(
                                      logMobilitas[index].id,
                                      logMobilitas[index].nama_barang,
                                      logMobilitas[index].gedung_sebelum,
                                      logMobilitas[index].ruangan_sebelum,
                                      logMobilitas[index].gedung_sesudah,
                                      logMobilitas[index].ruangan_sesudah,
                                      logMobilitas[index].date),
                                ],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          controller: ScrollController(keepScrollOffset: false),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],

                      //now expense
                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }

  Widget _card(
      int? id,
      String? nama_barang,
      String? gedung_sebelum,
      String? ruangan_sebelum,
      String? gedung_sesudah,
      String? ruangan_sesudah,
      String? date) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          // color: Color(0xff4d87b7),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Text(
                  nama_barang.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.pink),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              gedung_sebelum.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[900]),
                            ),
                            Text(
                              ruangan_sebelum.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Icon(
                        Icons.double_arrow,
                        color: Colors.pink,
                      ),
                      padding: EdgeInsets.all(12),
                    ),
                    Spacer(),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            gedung_sesudah.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900]),
                          ),
                          Text(
                            ruangan_sesudah.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  date.toString(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
