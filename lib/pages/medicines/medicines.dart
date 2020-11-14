import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/ebrast/single_drug.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Medicines extends StatefulWidget {
  final String type;
  Medicines({this.type});
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  bool loading = false;
  List<Medicine> searchData;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    if (main.medicines.isEmpty) {
      fetch();
    }
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    await getMedicines(context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Widgets.loader()
        : Consumer<MainModel>(builder: (context, main, child) {
            var medicines = searchData != null ? searchData : main.getMedicines;
            if (widget.type != null) {
              medicines = medicines
                  .where((element) => element.type == widget.type)
                  .toList();
            }
            var type = widget.type != null ? widget.type : '';
            return Pager(
              '${type.toUpperCase()} Medicines',
              medicines.isEmpty
                  ? [Widgets.centerText('No Medicine Available', context)]
                  : [
                      if (widget.type != null)
                        Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Widgets.text(
                                  main.getUser.settings[widget.type],
                                  color: Colors.white,
                                  size: 15,
                                  weight: FontWeight.bold),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: getTypeColor(widget.type),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                          children: List.generate(medicines.length, (index) {
                        Medicine medicine = medicines[index];
                        return Card(
                          child: ListTile(
                            title: Widgets.text(
                                medicine.name != null ? medicine.name : '',
                                weight: FontWeight.w400),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                            onTap: () {
                              Get.to(SingleDrug(medicine.id));
                            },
                          ),
                        );
                      }))
                    ],
              refresh: () => fetch(),
              bottomBarIndex: 2,
              search: true,
              onSearch: (data) {
                print(data);
                setState(() {
                  searchData = main.medicines
                      .where((medicine) => medicine.name
                          .toLowerCase()
                          .startsWith(data.toLowerCase()))
                      .toList();
                  print(searchData.length);
                });
              },
            );
          });
  }
}
