import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/ebrast/single_drug.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../api_functions.dart';

class DrugManagement extends StatefulWidget {
  final int id;
  DrugManagement(this.id);
  @override
  _DrugManagementState createState() => _DrugManagementState();
}

class _DrugManagementState extends State<DrugManagement> {
  Disease disease;
  List<Medicine> medicines;
  List<bool> panels = [];
  bool loading = false;

  // int currentIndex = 0;
  // List<Drug>

  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    medicines = main.getMedicines;
    disease = main.diseases
        .firstWhere((disease) => disease.id == widget.id, orElse: () => null);
    if (disease == null || disease.drugManagements.isEmpty) {
      fetch();
      // Widgets.snackbar('Pathogen not found');
      // Get.to(Pathogens());
    }
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    disease = await getDisease(widget.id, context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> types = [];

    if (disease.drugManagements.isNotEmpty) {
      types =
          disease.drugManagements.map((e) => e.type).toList().toSet().toList();
      //print(types);
      if (panels.isEmpty) {
        var keys = types.asMap().keys;

        keys.forEach((index) {
          panels.insert(index, false);
        });
      }
    }
    //return Container();
    return Pager(
        disease == null
            ? 'Disease not found'
            : "${disease.name} Drug Management",
        loading
            ? [Widgets.loader()]
            : disease == null
                ? [Widgets.centerText('Disease not found', context)]
                : disease.drugManagements.isEmpty
                    ? [Widgets.centerText('No Drug Management found', context)]
                    : [
                        Container(
                          padding: EdgeInsets.all(0.5),
                          child: Column(
                            // shrinkWrap: true,
                            children: List.generate(types.length, (index) {
                              var drugManagements = disease.drugManagements
                                  .where((e) => e.type == types[index])
                                  .toList();
                              var categories = drugManagements
                                  .map((e) => e.category)
                                  .toList()
                                  .toSet()
                                  .toList();
                              //print(categories);
                              return Widgets.collapsible(
                                types[index].toUpperCase(),
                                List.generate(categories.length, (index) {
                                  var drugManagements = disease.drugManagements
                                      .where((e) =>
                                          e.category == categories[index])
                                      .toList();
                                  var stages = drugManagements
                                      .map((e) => e.stage)
                                      .toList()
                                      .toSet()
                                      .toList();
                                  return ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Widgets.collapsible(
                                          categories[index].toUpperCase(),
                                          List.generate(stages.length, (index) {
                                            var drugManagements = disease
                                                .drugManagements
                                                .where((e) =>
                                                    e.stage == stages[index])
                                                .toList();
                                            var classes = drugManagements
                                                .map((e) => e.cLass)
                                                .toList()
                                                .toSet()
                                                .toList();
                                            return Widgets.collapsible(
                                                stages[index].toUpperCase(),
                                                List.generate(classes.length,
                                                    (index) {
                                                  var drugManagements = disease
                                                      .drugManagements
                                                      .where((e) =>
                                                          e.cLass ==
                                                          classes[index])
                                                      .toList();
                                                  var alternatives =
                                                      drugManagements
                                                          .map((e) =>
                                                              e.alternative)
                                                          .toList()
                                                          .toSet()
                                                          .toList();
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Widgets.header(
                                                          classes[index]
                                                              .toUpperCase()),
                                                      Column(
                                                          children:
                                                              List.generate(
                                                                  alternatives
                                                                      .length,
                                                                  (index) {
                                                        var drugManagements = disease
                                                            .drugManagements
                                                            .where((e) =>
                                                                e.alternative ==
                                                                alternatives[
                                                                    index])
                                                            .toList();

                                                        return Widgets.collapsible(
                                                            "Alternative ${alternatives[index].toString()}",
                                                            [
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: List.generate(
                                                                      drugManagements
                                                                          .length,
                                                                      (index) {
                                                                    var drug =
                                                                        drugManagements[
                                                                            index];
                                                                    Medicine
                                                                        medicine;
                                                                    if (drug.medicineName ==
                                                                        null) {
                                                                      medicine = medicines.firstWhere(
                                                                          (element) =>
                                                                              element.id ==
                                                                              drug
                                                                                  .medicineId,
                                                                          orElse: () =>
                                                                              null);
                                                                      if (medicine ==
                                                                          null) {
                                                                        getMedicine(drug.medicineId,
                                                                                context)
                                                                            .then((value) {
                                                                          setState(
                                                                              () {
                                                                            medicine =
                                                                                value;
                                                                          });
                                                                        });
                                                                      }
                                                                    }

                                                                    var medicineName = drug.medicineName !=
                                                                            null
                                                                        ? drug
                                                                            .medicineName
                                                                        : medicine !=
                                                                                null
                                                                            ? medicine.name
                                                                            : null;

                                                                    return medicineName ==
                                                                            null
                                                                        ? Container(
                                                                            child:
                                                                                ListTile(
                                                                              title: Text('Medicine Not Found'),
                                                                            ),
                                                                          )
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (medicine != null) {
                                                                                Get.to(SingleDrug(medicine.id));
                                                                              }
                                                                            },
                                                                            child:
                                                                                Card(
                                                                              child: Container(
                                                                                padding: EdgeInsets.all(15),
                                                                                child: Widgets.text('$medicineName ${drug.strength} ${drug.interval} for ${drug.duration}'),
                                                                              ),
                                                                            ),
                                                                          );
                                                                  }))
                                                            ]);
                                                      })),
                                                    ],
                                                  );
                                                }));
                                          })),
                                    ],
                                  );
                                }),
                                //isExpanded: panels[index],
                              );
                            }),
                            // ),
                            //],
                          ),
                        )
                      ],
        refresh: () => fetch());
    //);
  }
}
