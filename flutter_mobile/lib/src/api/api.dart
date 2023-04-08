import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

const String baseURL = "http://192.168.0.102:8000/api/"; //emulator localhost
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
}
