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
  final String? type;
  const Medicines({this.type, super.key});
  @override
  State<Medicines> createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  bool loading = false;
  List<Medicine>? searchData;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    if (main.medicines.isEmpty) {
      fetch();
    }
  }

  Future<void> fetch() async {
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
            var medicines = searchData ?? main.getMedicines;
            final selectedType = widget.type;
            if (selectedType != null) {
              medicines = medicines
                  .where((element) => element.type == selectedType)
                  .toList();
            }
            var type = selectedType ?? '';
            return Pager(
              '${type.toUpperCase()} Medicines',
              medicines.isEmpty
                  ? [Widgets.centerText('No Medicine Available', context)]
                  : [
                      if (selectedType != null)
                        Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Widgets.text(
                                  main.getUser?.settings[selectedType]
                                          ?.toString() ??
                                      'No data available',
                                  color: Colors.white,
                                  size: 15,
                                  weight: FontWeight.bold),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: getTypeColor(selectedType),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                          children: List.generate(medicines.length, (index) {
                        final medicine = medicines[index];
                        return Card(
                          child: ListTile(
                            title: Widgets.text(medicine.name,
                                weight: FontWeight.w400),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                            onTap: () {
                              Get.to(() => SingleDrug(medicine.id));
                            },
                          ),
                        );
                      }))
                    ],
              refresh: fetch,
              bottomBarIndex: 2,
              search: true,
              onSearch: (data) {
                setState(() {
                  searchData = main.medicines
                      .where((medicine) => medicine.name
                          .toLowerCase()
                          .startsWith(data.toLowerCase()))
                      .toList();
                });
              },
            );
          });
  }
}
