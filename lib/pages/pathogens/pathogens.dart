import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/pages/pathogens/each.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../api_functions.dart';

class Pathogens extends StatefulWidget {
  @override
  _PathogensState createState() => _PathogensState();
}

class _PathogensState extends State<Pathogens> {
  bool loading = false;
  List<Pathogen> searchData;

  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    if (main.pathogens.isEmpty) {
      fetch();
    }
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    await getPathogens(context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Widgets.loader()
        : Consumer<MainModel>(builder: (context, main, child) {
            //print(main.pathogens[0].antibiogramDatas[0]);
            var pathogens = searchData != null ? searchData : main.pathogens;

            return Pager(
              'Pathogens',
              pathogens.isEmpty
                  ? [Widgets.centerText('No Pathogen Available', context)]
                  : List.generate(pathogens.length, (index) {
                      Pathogen pathogen = pathogens[index];
                      return Card(
                        child: ListTile(
                          title: Widgets.text(pathogen.name,
                              weight: FontWeight.w400),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EachPathogen(pathogen.id)));
                          },
                        ),
                      );
                    }),
              //willPop: false,
              refresh: () => fetch(),
              search: true,
              onSearch: (data) {
                print(data);
                setState(() {
                  searchData = main.pathogens
                      .where((pathogen) => pathogen.name
                          .toLowerCase()
                          .startsWith(data.toLowerCase()))
                      .toList();
                  //print(searchData.length);
                });
              },
              bottomBarIndex: 1,
            );
          });
  }
}
