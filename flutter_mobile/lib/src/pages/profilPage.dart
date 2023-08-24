import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/api/model/profil.dart';
import 'package:flutter_mobile/src/loginPage.dart';
import '../Widget/colors.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:http/http.dart' as http;

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Profil profil = Profil();

  @override
  void initState() {
    API.getProfil(context).then((value) {
      setState(() {
        profil = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 25, right: 20, left: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Container(
                          width: (size.width) * 0.5,
                          child: Column(
                            children: [
                              Text(
                                "Profil Pengguna",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _card(Icons.person_2_outlined, "Nama :",
                      profil.name.toString()),
                  _card(Icons.account_balance_rounded, "Instansi :",
                      profil.instansi.toString()),
                  _card(Icons.star_border, "Jabatan :",
                      profil.jabatan.toString()),
                  _card(
                      Icons.email_outlined, "Email :", profil.email.toString()),
                  _card(Icons.home_outlined, "Alamat :",
                      profil.alamat.toString()),
                  _card(
                      Icons.phone_outlined, "No HP :", profil.no_hp.toString()),
                  InkWell(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.scale,
                        headerAnimationLoop: true,
                        title: 'Anda yakin ingin Logout ?',
                        btnOkOnPress: () async {
                          try {
                            http.Response response = await API.logout(context);
                            if (response.statusCode == 200) {
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => new LoginPage()));
                              // progressDialog.dismiss();
                            }
                          } catch (e) {}
                        },
                        btnCancelOnPress: () {},
                        btnCancelColor: Colors.red,
                        btnOkColor: Color(0xff4d87b7),
                        onDismissCallback: (type) {
                          // progressDialog.dismiss();
                        },
                      ).show();
                    },
                    child: Container(
                      margin: EdgeInsets.all(25),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
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
                        'Logout',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _card(IconData? icon, String? judul, String? data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Icon(
              icon,
              color: Colors.orange,
            ),
            padding: EdgeInsets.all(12),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$judul",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[500]),
                ),
                Text(
                  "$data",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
