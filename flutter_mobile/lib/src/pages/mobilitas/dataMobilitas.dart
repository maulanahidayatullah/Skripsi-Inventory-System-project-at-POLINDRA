import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/api/model/logMobilitas.dart';
import 'package:flutter_mobile/src/pages/mobilitasPage.dart';
import '../../api/model/mobilitas.dart';
import '../../api/model/gedungRuangan.dart';
import 'package:ndialog/ndialog.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_mobile/src/Widget/menu.dart';

class DataMobilitas extends StatefulWidget {
  const DataMobilitas({super.key});

  @override
  State<DataMobilitas> createState() => _DataMobilitasState();
}

class _DataMobilitasState extends State<DataMobilitas> {
  List<Mobilitas> listMobilitas = [];
  List<GedungRuangan> listGedungRuangan = [];
  API api = API();

  getDataMobilitas() async {
    listMobilitas = await api.getMobilitas(context);
    setState(() {});
  }

  var url = Uri.parse(API.baseURL + 'get_gedung_ruangan');

  var _gedung = [];
  var _ruangan = [];

  String? gedung;
  String? ruangan;

  bool isGedungSelected = false;
  bool isRuanganSelected = false;

  Future getGedungRuangan() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: Text("Mohon Tunggu..."),
    );
    progressDialog.show();
    var response = await http.post(url);

    if (response.statusCode == 200) {
      progressDialog.dismiss();
      var jsonResponse = jsonDecode(response.body)['data'];

      setState(() {
        _gedung = jsonResponse;

        _cardModal();
      });
    }
  }

  @override
  void initState() {
    getDataMobilitas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listMobilitas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Keranjang Mobilitas'),
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
                      API.tambahMobilitas(nup).then((value) async {
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
                        getDataMobilitas();
                      });
                    } catch (e) {}
                  });
                }
              },
            ),
          ],
          backgroundColor: Colors.pink,
        ),
        body: Container(
          child: Center(
            child: Text(
              'Tidak Ada Data',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.green[300]),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Keranjang Mobilitas'),
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
                      API.tambahMobilitas(nup).then((value) async {
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
                        getDataMobilitas();
                      });
                    } catch (e) {}
                  });
                }
              },
            ),
          ],
          backgroundColor: Colors.pink,
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: listMobilitas.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _card(
                          listMobilitas[index].id,
                          listMobilitas[index].kode_barang,
                          listMobilitas[index].nama_barang,
                          listMobilitas[index].merk_type,
                          listMobilitas[index].gedung,
                          listMobilitas[index].ruangan,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () async {
                getGedungRuangan();
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
      String? merk_type, String? gedung, String? ruangan) {
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
                      height: 15,
                    ),
                    Text("Gedung : ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(gedung.toString(), style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Ruangan : ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(ruangan.toString(), style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: SizedBox(
                          height: 10,
                        )),
                        // child: Text(kode_barang.toString(),
                        //     style: TextStyle(fontSize: 20))),
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
                                    getDataMobilitas();
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
                                  fontSize: 20,
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
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Silahkan pilih Gedung dan Ruangan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_gedung.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.pink),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButton<String>(
                              underline: Container(),
                              hint: Text("-- Gedung --"),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              isDense: true,
                              isExpanded: true,
                              items: _gedung.map((gdng) {
                                return DropdownMenuItem<String>(
                                    value: gdng["id_gedung"].toString(),
                                    child: Text(gdng["gedung"]));
                              }).toList(),
                              value: gedung,
                              onChanged: (value) {
                                setState(() {
                                  _ruangan = [];
                                  gedung = value;
                                  // Nggo cek type variabel
                                  // print(value.runtimeType);
                                  // print(_gedung[0]['id_gedung'].runtimeType);
                                  for (int i = 0; i < _gedung.length; i++) {
                                    if (_gedung[i]["id_gedung"].toString() ==
                                        value) {
                                      // print(_gedung[i]['ruangan']);
                                      _ruangan = _gedung[i]["ruangan"];
                                      // _ruangan = ;
                                    }
                                  }
                                  isGedungSelected = true;
                                });
                              }),
                        ),
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    // if (isGedungSelected == false)
                    //   const Center(child: CircularProgressIndicator())
                    // else
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButton<String>(
                            underline: Container(),
                            hint: Text("-- Ruangan --"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isDense: true,
                            isExpanded: true,
                            items: _ruangan.map((rngn) {
                              return DropdownMenuItem<String>(
                                  value: rngn["id_ruangan"].toString(),
                                  child: Text(rngn["ruangan"]));
                            }).toList(),
                            value: ruangan,
                            onChanged: (value) {
                              setState(() {
                                ruangan = value;
                                isGedungSelected = false;
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        // print(int.parse(gedung).runtimeType);
                        var gedung_id = int.parse(gedung!);
                        var ruangan_id = int.parse(ruangan!);
                        ProgressDialog progressDialog = ProgressDialog(
                          context,
                          blur: 10,
                          message: Text("Mohon Tunggu..."),
                        );
                        listMobilitas.forEach((value) {
                          try {
                            API
                                .selesaiMobilitas(
                                    value.id, gedung_id, ruangan_id)
                                .then((value) async {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.scale,
                                headerAnimationLoop: true,
                                title: 'Mobilitas Barang berhasil',
                                btnOkOnPress: () {},
                                onDismissCallback: (type) {
                                  progressDialog.dismiss();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu()));
                                },
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.blue,
                              ).show();
                            });
                          } catch (e) {}
                        });
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
