import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../api/model/inventori.dart';

const String baseURL = "http://192.168.0.103:8000/api/"; //emulator localhost
const Map<String, String> header = {"Content-Type": "application/json"};

class API {
  static void gagal(BuildContext context, ProgressDialog pDialog) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      headerAnimationLoop: true,
      title: 'Gagal Terhubung Ke Server',
      btnOkOnPress: () {},
      onDismissCallback: (type) {
        pDialog.dismiss();
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  static Future<http.Response> login(
      String email, String password, BuildContext context) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'login');

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
    );

    try {
      return response;
    } catch (e) {
      return response;
    }
  }

  static Future<Inventori> cekInventori(
    String kode_barang,
  ) async {
    Uri url = Uri.parse(baseURL + 'cek_inventori');

    int code = int.parse(kode_barang);

    Map data = {
      "kode_barang": code,
    };
    var body = json.encode(data);

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
    );

    bool success = json.decode(response.body)["success"];
    var data_inventori = json.decode(response.body)["data"];

    if (response.statusCode == 200) {
      // print(data_inventori["nama_barang"]);
      return Inventori(
        id: data_inventori["id"],
        qty: data_inventori["qty"],
        harga: data_inventori["harga"],
        nup: data_inventori["nup"],
        kode_barang: data_inventori["kode_barang"],
        nilai_bmn: data_inventori["nilai_bmn"],
        jurusan_id: data_inventori["jurusan_id"],
        gedung_id: data_inventori["gedung_id"],
        ruangan_id: data_inventori["ruangan_id"],
        merk: data_inventori["merk"],
        tahun: data_inventori["tahun"],
        nama_barang: data_inventori["nama_barang"],
        qr: data_inventori["qr"],
        pelabelan: data_inventori["pelabelan"],
        kondisi: data_inventori["kondisi"],
        keterangan: data_inventori["keterangan"],
        success: success,
      );
    } else {}
    return Inventori(
      success: success,
    );
  }
}
