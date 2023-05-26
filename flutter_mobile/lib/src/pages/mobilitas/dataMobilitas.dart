import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/api/model/inventori.dart';
import '../../api/model/mobilitas.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ndialog/ndialog.dart';
import 'package:qrscan/qrscan.dart' as Scanner;

class DataMobilitas extends StatefulWidget {
  const DataMobilitas({super.key});

  @override
  State<DataMobilitas> createState() => _DataMobilitasState();
}

class _DataMobilitasState extends State<DataMobilitas> {
  List<Mobilitas> listMobilitas = [];
  API api = API();

  getDataMobilitas() async {
    listMobilitas = await api.getMobilitas(context);
    setState(() {});
  }

  @override
  void initState() {
    // http.getSemester_1();
    getDataMobilitas();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Inventori inventori = Inventori();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobilitas'),
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
                    API.tambahMobilitas(int.parse(nup)).then((value) async {
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
      ),
      body: Container(
        child: ListView.builder(
          itemCount: listMobilitas.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _card(
                      listMobilitas[index].kode_barang,
                      listMobilitas[index].nama_barang,
                      listMobilitas[index].merk_type,
                      listMobilitas[index].gedung,
                      listMobilitas[index].ruangan),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _card(int? kode_barang, String? nama_barang, String? merk_type,
      String? gedung, String? ruangan) {
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
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(merk_type.toString(), style: TextStyle(fontSize: 18)),
                    Text(
                      nama_barang.toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //         child: Text("Date: 14-06-2021",
                    //             style: TextStyle(fontSize: 24))),
                    //     Expanded(
                    //       // child: FlatButton(
                    //       //   onPressed: () {},
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             color: Colors.red,
                    //             borderRadius: BorderRadius.circular(5)),
                    //         padding: EdgeInsets.all(4),
                    //         child: Text(
                    //           "Hapus",
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 24,
                    //           ),
                    //         ),
                    //       ),
                    //       // ),
                    //     )
                    //   ],
                    // ),
                    Text("Time: 10:20", style: TextStyle(fontSize: 24)),
                    SizedBox(
                      height: 20,
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
}
