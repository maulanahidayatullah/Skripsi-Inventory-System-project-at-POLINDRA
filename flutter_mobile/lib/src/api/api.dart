import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../api/model/inventori.dart';
import '../api/model/profil.dart';

const String baseURL =
    "https://0a29-103-158-121-155.ngrok-free.app/api/"; //emulator localhost
const Map<String, String> header = {"Content-Type": "application/json"};

class API {
  static Future<int> getUserId() async {
    // String? token = await getToken();

    String? token = "41|nSScKc4LdSvzlWavT6KZmkjsgF37BYpxIi154BEX";
    Uri url = Uri.parse(baseURL + 'user');

    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return json.decode(response.body)["id"];
  }

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

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> login(
    String email,
    String password,
  ) async {
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

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(
          'token', json.decode(response.body)["data"]["token"].toString());
    }
    return response;
  }

  static Future<http.Response> logout(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: Text("Mohon Tunggu..."),
    );
    progressDialog.show();
    String? token = await getToken();

    Uri url = Uri.parse(baseURL + 'logout');

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
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

  static Future<Profil> getProfil(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: Text("Mohon Tunggu..."),
    );
    Future.delayed(Duration.zero, () {
      progressDialog.show();
    });

    Uri url = Uri.parse(baseURL + 'profil');

    int user_id = await getUserId();

    Map data = {
      "user_id": user_id,
    };

    var body = json.encode(data);

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
    );

    var data_profil = json.decode(response.body)['data'];

    bool success = json.decode(response.body)["success"];

    if (response.statusCode == 200) {
      progressDialog.dismiss();
      return Profil(
        nama: data_profil['nama'],
        alamat: data_profil['alamat'],
        jabatan: data_profil['jabatan'],
        no_hp: data_profil['no_hp'],
        email: data_profil['email'],
        success: success,
      );
    } else {}
    return Profil(
      success: success,
    );
  }

  static Future<int?> cekMobilitas(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: Text("Mohon Tunggu..."),
    );
    Future.delayed(Duration.zero, () {
      progressDialog.show();
    });

    Uri url = Uri.parse(baseURL + 'cek_mobilitas');

    int user_id = await getUserId();

    Map data = {
      "user_id": user_id,
    };

    var body = json.encode(data);

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
    );

    if (response.statusCode == 200) {
      progressDialog.dismiss();
      return 1;
    } else {
      progressDialog.dismiss();
      return 0;
    }
  }
}
