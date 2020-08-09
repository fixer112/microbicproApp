import 'package:flutter/material.dart';

import '../values.dart';

class Pager extends StatefulWidget {
  final String title;
  final List<Widget> widgets;

  const Pager(this.title, this.widgets, {Key key}) : super(key: key);

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon( Icons.arrow_back ), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text( widget.title ),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: widget.widgets,
      ),
    );
  }
}