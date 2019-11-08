import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_band_name/src/ui/lista_nome_page.dart';

class BandNameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Band Name',
      home: ListaNomePage(),
    );
  }
}
