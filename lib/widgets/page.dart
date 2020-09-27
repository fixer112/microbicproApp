import 'package:flutter/material.dart';
import 'package:microbicpro/pages/search_page.dart';

import '../values.dart';

class Pager extends StatefulWidget {
  final String title;
  final List<Widget> widgets;
  final bool search;
  final bool willPop;

  const Pager(this.title, this.widgets,
      {Key key, this.search, this.willPop = true})
      : super(key: key);

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => widget.willPop,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              widget.search != false
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SearchPage()));
                      },
                    )
                  : Container(),
            ],
            title: Text(widget.title),
            backgroundColor: primaryColor,
          ),
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            children: widget.widgets,
          ),
        ));
  }
}
