import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DataPeminjaman extends StatefulWidget {
  const DataPeminjaman({super.key});

  @override
  State<DataPeminjaman> createState() => _DataPeminjamanState();
}

class _DataPeminjamanState extends State<DataPeminjaman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Peminjaman'),
        actions: <Widget>[
          IconButton(
            padding: new EdgeInsets.only(right: 10),
            icon: const Icon(
              Icons.add_circle,
              size: 35,
            ),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                headerAnimationLoop: true,
                title: 'Tambah Data Mobilitas',
                btnOkIcon: Icons.cancel,
                btnOkColor: Colors.blue,
              ).show();
            },
          ),
        ],
      ),
    );
  }
}
