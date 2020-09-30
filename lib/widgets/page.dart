import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microbicpro/pages/ebrast/ebrast.dart';
import 'package:microbicpro/pages/guidelines/guidelines.dart';
import 'package:microbicpro/pages/medicines/medicines.dart';
import 'package:microbicpro/pages/pathogens/pathogens.dart';
import 'package:microbicpro/pages/search_page.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../values.dart';

class Pager extends StatefulWidget {
  final String title;
  final List<Widget> widgets;
  final bool search;
  final bool willPop;
  final int bottomBarIndex;

  const Pager(this.title, this.widgets,
      {Key key, this.search, this.willPop = true, this.bottomBarIndex = 0})
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

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: widget.bottomBarIndex,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Widgets.gradienticon(
                  FontAwesomeIcons.checkSquare,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.orange,
                      Colors.pink,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                title: Widgets.text('Guidelines', color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Widgets.gradienticon(
                  FontAwesomeIcons.disease,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.blue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                title: Widgets.text('Pathogens', color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Widgets.gradienticon(
                  FontAwesomeIcons.bookMedical,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.indigo,
                      Colors.purple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                title: Widgets.text('Medicines', color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Widgets.gradienticon(
                  FontAwesomeIcons.questionCircle,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.red,
                      Colors.brown,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                title: Widgets.text('Ebrast', color: Colors.black),
              ),
            ],

            onTap: (index){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => [
                Guidelines(),
                Pathogens(),
                Medicines(),
                Ebrast()
              ][index]));
            },
          ),
        ));
  }
}
