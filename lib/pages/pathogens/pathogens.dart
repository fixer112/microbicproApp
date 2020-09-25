import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/pages/pathogens/each.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Pathogens extends StatefulWidget {
  @override
  _PathogensState createState() => _PathogensState();
}

class _PathogensState extends State<Pathogens> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getPathogens();
  }

  getPathogens() async {
    setState(() {
      loading = true;
    });
    try {
      var main = Provider.of<MainModel>(context, listen: false);

      var link = '$url/api/pathogens';
      var response = await http.get(link, headers: {
        'Accept': 'application/json',
      });
      var body = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${body[0]['precausions'].runtimeType}');
      List<Pathogen> pathogens =
          List<Pathogen>.from(body.map((i) => Pathogen.fromMap(i)).toList());

      main.setPathogens(pathogens);
    } on SocketException {
      Widgets.snackbar('Please Connect to the internet');
    } catch (e) {
      print(e);
      Widgets.snackbar('An Error Occured');
    }
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
            return Pager(
              'Pathogens',
              main.pathogens != null
                  ? List.generate(main.pathogens.length, (index) {
                      Pathogen pathogen = main.pathogens[index];
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
                    })
                  : [Widgets.centerText('No Pathogen Available')],
            );
          });
  }
}
