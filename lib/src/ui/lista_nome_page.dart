import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_band_name/src/model/record.dart';

class ListaNomePage extends StatefulWidget {
  @override
  _ListaNomePageState createState() => _ListaNomePageState();
}

class _ListaNomePageState extends State<ListaNomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _constroiCorpo(context),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _appBar() => AppBar(
        title: Text('Nomes de Bandas'),
      );

  Widget _bottomBar() => BottomAppBar(
        color: Colors.lightBlue,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Vote em um dos nomes acima',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget _constroiCorpo(BuildContext context) => StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('bandnames').snapshots(),
      builder: (context, snapshot) {
        return Center(
          child: snapshot.hasData
              ? _constroiLista(context, snapshot.data.documents)
              : CircularProgressIndicator(),
        );
      });

  Widget _constroiLista(BuildContext context, List<DocumentSnapshot> data) => ListView(
        padding: const EdgeInsets.only(top: 4.0),
        children: data.map((data) => _constroiItemLista(context, data)).toList(),
      );

  Widget _constroiItemLista(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => record.increment(),
          onLongPress: () => record.decrement(),
        ),
      ),
    );
  }
}
