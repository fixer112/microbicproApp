import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/ebrast/single_drug.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Medicines extends StatefulWidget {
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  bool loading = false;
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
            var medicines = main.getMedicines;
            return Pager(
                'Medicines',
                medicines.isEmpty
                    ? [Widgets.centerText('No Medicine Available', context)]
                    : List.generate(medicines.length, (index) {
                        Medicine medicine = medicines[index];
                        return Card(
                          child: ListTile(
                            title: Widgets.text(medicine.name,
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
                      }),
                //willPop: false,
                refresh: () => fetch());
          });
  }
}
