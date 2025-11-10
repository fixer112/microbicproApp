import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/DrugManagement.dart' as model_dm;
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
  const DrugManagement(this.id, {super.key});

  @override
  State<DrugManagement> createState() => _DrugManagementState();
}

class _DrugManagementState extends State<DrugManagement> {
  Disease? disease;
  List<Medicine> medicines = [];
  final List<bool> panels = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final main = Provider.of<MainModel>(context, listen: false);
    medicines = main.getMedicines;
    final matches = main.diseases.where((disease) => disease.id == widget.id);
    disease = matches.isNotEmpty ? matches.first : null;
    if (disease == null || disease!.drugManagements.isEmpty) {
      fetch();
    }
  }

  Future<void> fetch() async {
    setState(() => loading = true);
    disease = await getDisease(widget.id, context);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final currentDisease = disease;
    final List<Widget> content = loading
        ? [Widgets.loader()]
        : currentDisease == null
            ? [Widgets.centerText('Disease not found', context)]
            : currentDisease.drugManagements.isEmpty
                ? [
                    Widgets.centerText('No Drug Management found', context),
                  ]
                : [
                    _buildDrugManagementList(currentDisease),
                  ];

    return Pager(
      currentDisease == null
          ? 'Disease not found'
          : '${currentDisease.name} Drug Management',
      content,
      refresh: fetch,
    );
  }

  Widget _buildDrugManagementList(Disease disease) {
    final types = disease.drugManagements.map((e) => e.type).toSet().toList();
    if (panels.isEmpty) {
      for (final index in types.asMap().keys) {
        panels.insert(index, false);
      }
    }

    return Container(
      padding: const EdgeInsets.all(0.5),
      child: Column(
        children: List.generate(types.length, (typeIndex) {
          final type = types[typeIndex];
          final drugManagements =
              disease.drugManagements.where((e) => e.type == type).toList();
          final categories =
              drugManagements.map((e) => e.category).toSet().toList();
          categories.sort();
          return Widgets.collapsible(
            type.toUpperCase(),
            List.generate(categories.length, (categoryIndex) {
              final category = categories[categoryIndex];
              final catDrugs =
                  drugManagements.where((e) => e.category == category).toList();
              final stages = catDrugs.map((e) => e.stage).toSet().toList();
              stages.sort();
              return Column(
                children: List.generate(stages.length, (stageIndex) {
                  final stage = stages[stageIndex];
                  final stageDrugs =
                      catDrugs.where((e) => e.stage == stage).toList();
                  final classes =
                      stageDrugs.map((e) => e.cLass).toSet().toList();
                  classes.sort();
                  return Widgets.collapsible(
                    stage.toUpperCase(),
                    List.generate(classes.length, (classIndex) {
                      final className = classes[classIndex];
                      final classDrugs = stageDrugs
                          .where((e) => e.cLass == className)
                          .toList();
                      final alternatives =
                          classDrugs.map((e) => e.alternative).toSet().toList();
                      alternatives.sort(
                        (a, b) => (a ?? 0).compareTo((b ?? 0)),
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Widgets.header(className.toUpperCase()),
                          Column(
                            children:
                                List.generate(alternatives.length, (altIndex) {
                              final altValue = alternatives[altIndex];
                              final alternativeDrugs = classDrugs
                                  .where((e) => e.alternative == altValue)
                                  .toList();
                              final altTitle = altValue == null
                                  ? 'Alternative'
                                  : 'Alternative ${altValue.toString()}';
                              return Widgets.collapsible(
                                altTitle,
                                alternativeDrugs
                                    .map(_buildMedicineTile)
                                    .toList(),
                              );
                            }),
                          ),
                        ],
                      );
                    }).cast<Widget>(),
                  );
                }),
              );
            }).cast<Widget>(),
          );
        }).cast<Widget>(),
      ),
    );
  }

  Widget _buildMedicineTile(model_dm.DrugManagement drug) {
    final medicine =
        drug.medicineId == 0 ? null : _findMedicine(drug.medicineId);
    final medicineName =
        drug.medicineName.isNotEmpty ? drug.medicineName : medicine?.name;

    if (medicineName == null) {
      return ListTile(
        title: Widgets.text('Medicine Not Found'),
      );
    }

    final description =
        '$medicineName ${drug.strength} ${drug.interval} for ${drug.duration}';

    final canNavigate = drug.id != 0 && medicine != null;
    final targetMedicine = medicine;

    return InkWell(
      onTap: canNavigate && targetMedicine != null
          ? () => Get.to(() => SingleDrug(targetMedicine.id))
          : null,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Widgets.text(description),
        ),
      ),
    );
  }

  Medicine? _findMedicine(int id) {
    for (final medicine in medicines) {
      if (medicine.id == id) {
        return medicine;
      }
    }
    return null;
  }
}
