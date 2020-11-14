import 'dart:ui';

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
  ValueChanged<String> onSearch;

  Pager(
    this.title,
    this.widgets, {
    Key key,
    this.search = false,
    this.willPop = true,
    this.refresh,
    this.bottomBarIndex = 0,
    this.onSearch,
  });

  @override
  _PagerState createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  Future<bool> fetch() {
    return Future.delayed(Duration(microseconds: 10), () => true);
  }

  bool isSearching = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      //print(controller.text);
      widget.onSearch(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchWidget() {
      return Container(
        height: 50.0,
        margin: EdgeInsets.only(top: 10.0),
        child: TextField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: controller,
          decoration: InputDecoration(
            //fillColor: Colors.white,
            //filled: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 5.0)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 5.0)),
            //labelText: 'Your Email or Phone',
            labelText: 'Search',
            labelStyle: TextStyle(color: Colors.white),

            //contentPadding: EdgeInsets.all(10).copyWith(left: 30),
            //hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      );
    }

    ;
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
              widget.search
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                      },
                    )
                  : Container(),
            ],
            title: isSearching ? searchWidget() : Text(widget.title),
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
                title: Widgets.text('Profile', color: Colors.black),
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
