import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardMobilitas extends StatefulWidget {
  const CardMobilitas({super.key});

  @override
  State<CardMobilitas> createState() => _CardMobilitasState();
}

class _CardMobilitasState extends State<CardMobilitas> {
  API api = API();

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
      });
    }
  }

  @override
  void initState() {
    getGedungRuangan();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            "Silahkan pilih Gedung dan Ruangan",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
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
                        // ruangan = '';
                        _ruangan = [];
                        gedung = value!;
                        for (int i = 0; i < _gedung.length; i++) {
                          if (_gedung[i]["id_gedung"] == int.parse(value)) {
                            _ruangan = _gedung[i]["ruangan"];
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
                      // isGedungSelected = false;
                    });
                  }),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          // InkWell(
          //   onTap: () {
          //     // print(int.parse(gedung).runtimeType);
          //     var gedung_id = int.parse(gedung!);
          //     var ruangan_id = int.parse(ruangan!);
          //     ProgressDialog progressDialog = ProgressDialog(
          //       context,
          //       blur: 10,
          //       message: Text("Mohon Tunggu..."),
          //     );
          //     listMobilitas.forEach((value) {
          //       try {
          //         API
          //             .selesaiMobilitas(value.id, gedung_id, ruangan_id)
          //             .then((value) async {
          //           AwesomeDialog(
          //             context: context,
          //             dialogType: DialogType.success,
          //             animType: AnimType.scale,
          //             headerAnimationLoop: true,
          //             title: 'Mobilitas Barang berhasil',
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
          //     });
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     margin: EdgeInsets.symmetric(horizontal: 20),
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(5)),
          //         boxShadow: <BoxShadow>[
          //           BoxShadow(
          //               color: Colors.grey.shade200,
          //               offset: Offset(2, 4),
          //               blurRadius: 5,
          //               spreadRadius: 2)
          //         ],
          //         gradient: LinearGradient(
          //             begin: Alignment.centerLeft,
          //             end: Alignment.centerRight,
          //             colors: [Color(0xff85a7c7), Color(0xff4d87b7)])),
          //     child: Text(
          //       'Submit',
          //       style: TextStyle(fontSize: 20, color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      ),
    );
    ;
  }
}
