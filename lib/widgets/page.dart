import 'package:flutter/material.dart';
import 'package:microbicpro/pages/search_page.dart';

import '../values.dart';

class Pager extends StatefulWidget {
  final String title;
  final List<Widget> widgets;
  final bool search;
  final bool willPop;
  final Function refresh;

  const Pager(this.title, this.widgets,
      {Key key, this.search = false, this.willPop = true, this.refresh})
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
            /* leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }), */
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
          body: RefreshIndicator(
            onRefresh: () => widget.refresh(),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: widget.widgets,
            ),
          ),
        ));
  }
}
