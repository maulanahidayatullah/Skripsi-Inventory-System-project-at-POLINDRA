import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DataMobilitas extends StatefulWidget {
  const DataMobilitas({super.key});

  @override
  State<DataMobilitas> createState() => _DataMobilitasState();
}

class _DataMobilitasState extends State<DataMobilitas> {
  @override
  Widget build(BuildContext context) {
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
