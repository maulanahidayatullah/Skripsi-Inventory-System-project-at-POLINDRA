import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../api/model/inventori.dart';
import '../api/model/profil.dart';
import '../api/model/mobilitas.dart';

const String baseURL = "http://192.168.0.109:8000/api/"; //emulator localhost
const Map<String, String> header = {"Content-Type": "application/json"};

class API {
  static Future<int> getUserId() async {
    // String? token = await getToken();

    String? token = "8|sFfNSCF29nSUri2Hy5dzXK5uZEWJqOUczHtk6Nl0";
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
    String qr,
  ) async {
    Uri url = Uri.parse(baseURL + 'cek_inventori');

    int nup = int.parse(qr);

    Map data = {
      "nup": nup,
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
        kode_barang: data_inventori["kode_barang"],
        nup: data_inventori["nup"],
        kuantitas: data_inventori["kuantitas"],
        nilai_bmn: data_inventori["nilai_bmn"],
        nama_barang: data_inventori["nama_barang"],
        tahun_perolehan: data_inventori["tahun_perolehan"],
        merk_type: data_inventori["merk_type"],
        kondisi_barang: data_inventori["kondisi_barang"],
        keberadaan_barang: data_inventori["keberadaan_barang"],
        pelabelan_kodefikasi: data_inventori["pelabelan_kodefikasi"],
        pegawai: data_inventori["pegawai"],
        gedung: data_inventori["gedung"]["gedung"],
        ruangan: data_inventori["ruangan"]["ruangan"],
        status_psp: data_inventori["status_psp"],
        nama_sub_satker: data_inventori["nama_sub_satker"],
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

    var data_mobilitas = json.decode(response.body)['data'];

    if (response.statusCode == 200) {
      progressDialog.dismiss();
      return 1;
    } else {
      progressDialog.dismiss();
      return 0;
    }
  }

  Future getMobilitas(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: Text("Mohon Tunggu..."),
    );
    Future.delayed(Duration.zero, () {
      progressDialog.show();
    });

    Uri url = Uri.parse(baseURL + 'get_mobilitas');

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

    var data_mobilitas = json.decode(response.body)['data'];

    if (response.statusCode == 200) {
      Iterable it = data_mobilitas;
      List<Mobilitas> mobilitas = it.map((e) => Mobilitas.fromJson(e)).toList();

      progressDialog.dismiss();
      return mobilitas;
    } else {
      progressDialog.dismiss();
      return 0;
    }
  }

  static Future<String?> tambahMobilitas(
    int? nup,
  ) async {
    print(nup);
    int user_id = await getUserId();

    Map data = {"nup": nup, "user_id": user_id};

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'tambah_mobilitas');

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
    );

    // print(response.body);
    var success = json.decode(response.body)['success'];
    var note = json.decode(response.body)['note'];
    // print(note);

    if (success == false) {
      return note;
    }
    return note;
  }
}
