import 'package:flutter/material.dart';

class ListPeditor extends StatefulWidget {
  final nameUser;
  ListPeditor(this.nameUser, {Key? key}) : super(key: key);

  @override
  _ListPeditorState createState() => _ListPeditorState();
}

class _ListPeditorState extends State<ListPeditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Anthony")),
        body: Container(
          height: 250.0,
          width: 250.0,
          color: Colors.deepPurple,
        ));
  }
}
