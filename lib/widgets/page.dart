import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/auth/profile.dart';
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
  final Function refresh;
  final int bottomBarIndex;

  Pager(
    this.title,
    this.widgets, {
    Key key,
    this.search = false,
    this.willPop = true,
    this.refresh,
    this.bottomBarIndex = 0,
  });

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  Future<bool> fetch() {
    return Future.delayed(Duration(microseconds: 10), () => true);
  }

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
            onRefresh: () async {
              if (widget.refresh != null) {
                widget.refresh();
              }
              return fetch();
            },
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: widget.widgets,
            ),
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
                label: 'Guidelines',
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
                label: 'Pathogens',
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
                label: 'Medicines',
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
                label: 'Ebrast',
              ),
              BottomNavigationBarItem(
                icon: Widgets.gradienticon(
                    FontAwesomeIcons.user,
                    20,
                    LinearGradient(
                      colors: <Color>[
                        Colors.red,
                        Colors.brown,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              return Get.to([
                Guidelines(),
                Pathogens(),
                Medicines(),
                Ebrast(),
                Profile(),
              ][index]);
              /* Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => [
                            Guidelines(),
                            Pathogens(),
                            Medicines(),
                            Ebrast()

                          ][index])) ;*/
            },
          ),
        ));
  }
}
