import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/Widget/menu.dart';
import 'package:flutter_mobile/src/Widget/intCheck.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/pages/dashboard.dart';
import 'package:ndialog/ndialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Widget/bezierContainer.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txPass = new TextEditingController();

  ceklogin() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: Text("Mohon Tunggu..."),
    );
    progressDialog.show();
    try {
      http.Response response = await API.login(_email, _password);
      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          headerAnimationLoop: true,
          title: 'Bener',
          // desc: 'Username atau Password Salah !',
          onDismissCallback: (type) {
            progressDialog.dismiss();
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.blue,
        ).show();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Menu()), (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          headerAnimationLoop: true,
          title: 'Username atau Password Salah !',
          btnOkOnPress: () {},
          onDismissCallback: (type) {
            progressDialog.dismiss();
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
        txEmail.text = "";
        txPass.text = "";
      }
    } catch (e) {
      API.gagal(context, progressDialog);
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          ceklogin();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
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
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _entryEmail() {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        // keyboardType: TextInputType.number,
        controller: txEmail,
        style: TextStyle(fontSize: 18),
        showCursor: true,
        autofocus: true,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          labelText: 'Email',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Email tidak boleh Kosong";
          } else {
            return null;
          }
        },
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _entryPassword() {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        controller: txPass,
        obscureText: _obscureText,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Password',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Password tidak boleh Kosong";
          } else {
            return null;
          }
        },
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _title() {
    return Image.asset(
      'assets/logo.png',
      width: 140,
      height: 140,
    );
  }

  Widget _emailPasswordWidget() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _entryEmail(),
            SizedBox(
              height: 15,
            ),
            _entryPassword(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 40),
                  _emailPasswordWidget(),
                  SizedBox(height: 40),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Lupa Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  // _divider(),
                  // _facebookButton(),
                  // _createAccountLabel(),
                ],
              ),
            ),
          ),
          // Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
