import 'package:flutter/material.dart';
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/model/medicine.dart';
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
    main.getMedicines().then((value) => medicines = value);
    main.getDiseases().then((value) {
      disease = value.firstWhere((disease) => disease.id == widget.id,
          orElse: () => null);
      if (disease == null || disease.drugManagements.isEmpty) {
        fetch();
      }
    });
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
      if (panels.isEmpty) {
        var keys = types.asMap().keys;

        keys.forEach((index) {
          panels.insert(index, false);
        });
      }

      //print(types.length);
    }
    //return Container();
    return /* DefaultTabCorntroller(
      length: types.length,
      child:  */
        Pager(
            disease == null
                ? 'Disease not found'
                : "${disease.name} Drug Management",
            loading
                ? [Widgets.loader()]
                : disease == null
                    ? [Widgets.centerText('Disease not found', context)]
                    : disease.drugManagements.isEmpty
                        ? [
                            Widgets.centerText(
                                'No Drug Management found', context)
                          ]
                        : [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ListView(children: [
                                ExpansionPanelList(
                                  expansionCallback: (index, isExpanded) {
                                    setState(() {
                                      panels[index] = !isExpanded;
                                    });
                                    //print(index);
                                  },
                                  children:
                                      List.generate(types.length, (index) {
                                    // print(types);
                                    // print(panels);

                                    var drugManagements = disease
                                        .drugManagements
                                        .where((e) => e.type == types[index])
                                        .toList();
                                    var categories = drugManagements
                                        .map((e) => e.category)
                                        .toList();
                                    return Widgets.expansion(
                                      types[index].toUpperCase(),
                                      List.generate(categories.length, (index) {
                                        var stageDrugManagements =
                                            drugManagements
                                                .where((element) =>
                                                    element.category ==
                                                    categories[index])
                                                .toList();
                                        //print(stageDrugManagements[0].category);
                                        var stages = stageDrugManagements
                                            .map((e) => e.stage)
                                            .toList();

                                        return Widgets.collapsible(
                                            categories[index].toUpperCase(),
                                            List.generate(stages.length,
                                                (index) {
                                              var classDrugManageMents =
                                                  stageDrugManagements
                                                      .where((element) =>
                                                          element.stage ==
                                                          stages[index])
                                                      .toList();
                                              var classes = stageDrugManagements
                                                  .map((e) => e.cLass)
                                                  .toList()
                                                  .toSet()
                                                  .toList();
                                              return Column(
                                                children: [
                                                  Widgets.header(stages[index]
                                                      .toUpperCase()),
                                                  Column(
                                                    children: List.generate(
                                                        classes.length,
                                                        (index) {
                                                      var alternativeDrugManageMents =
                                                          stageDrugManagements
                                                              .where((element) =>
                                                                  element
                                                                      .cLass ==
                                                                  classes[
                                                                      index])
                                                              .toList();
                                                      var alternatives =
                                                          alternativeDrugManageMents
                                                              .map((e) =>
                                                                  e.alternative)
                                                              .toList()
                                                              .toSet()
                                                              .toList();
                                                      return Widgets
                                                          .collapsible(
                                                              classes[index]
                                                                  .toUpperCase(),
                                                              List.generate(
                                                                  alternatives
                                                                      .length,
                                                                  (index) {
                                                                var drugs = alternativeDrugManageMents
                                                                    .where((element) =>
                                                                        element
                                                                            .alternative ==
                                                                        alternatives[
                                                                            index])
                                                                    .toList();
                                                                return Widgets
                                                                    .collapsible(
                                                                        "Alternative ${alternatives[index].toString()}",
                                                                        [
                                                                      Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .stretch,
                                                                          children: List.generate(
                                                                              alternativeDrugManageMents.length,
                                                                              (index) {
                                                                            var drug =
                                                                                alternativeDrugManageMents[index];
                                                                            Medicine
                                                                                medicine =
                                                                                medicines.firstWhere((element) => element.id == drug.medicineId, orElse: () => null);
                                                                            if (medicine ==
                                                                                null) {
                                                                              getMedicine(drug.medicineId, context).then((value) {
                                                                                setState(() {
                                                                                  medicine = value;
                                                                                });
                                                                              });
                                                                            }

                                                                            return medicine == null
                                                                                ? Container(
                                                                                    child: ListTile(
                                                                                      title: Text('Medicine Not Found'),
                                                                                    ),
                                                                                  )
                                                                                : Card(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.all(15),
                                                                                      child: Widgets.text('${medicine.name} ${drug.strength} ${drug.interval} for ${drug.duration}'),
                                                                                    ),
                                                                                  );
                                                                          }))
                                                                    ]);
                                                              }));
                                                    }),
                                                  )
                                                ],
                                              );
                                            }));
                                      }),
                                      isExpanded: panels[index],
                                    );
                                  }),
                                ),
                              ]),
                            )
                          ],
            refresh: () => fetch());
    //);
  }
}
