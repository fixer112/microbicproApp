import 'package:flutter/material.dart';
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/pages/guidelines/disease/drug.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../api_functions.dart';

class SingleDisease extends StatefulWidget {
  final int id;
  const SingleDisease(this.id, {super.key});
  @override
  State<SingleDisease> createState() => _SingleDiseaseState();
}

class _SingleDiseaseState extends State<SingleDisease> {
  Disease? disease;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    final main = Provider.of<MainModel>(context, listen: false);
    final matches = main.diseases.where((disease) => disease.id == widget.id);
    disease = matches.isNotEmpty ? matches.first : null;
    if (disease == null) {
      fetch();
      // Widgets.snackbar('Pathogen not found');
      // Get.to(Pathogens());
    }
  }

  Future<void> fetch() async {
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
    final current = disease;
    return Pager(
        current == null ? 'Disease Not Found' : "Disease - ${current.name}",
        loading
            ? [Widgets.loader()]
            : current == null
                ? [Widgets.centerText('Disease Not Found', context)]
                : [
                    Widgets.collapsible(
                        'Overview', [Widgets.text(current.overview)]),
                    Widgets.collapsible(
                        'Clinical Features', [Widgets.text(current.features)]),
                    Widgets.collapsible('Treatment Objectives',
                        [Widgets.text(current.treatmentObjectives)]),
                    Card(
                      child: ListTile(
                        title: Widgets.text('Drug Management',
                            size: 17, weight: FontWeight.w600),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DrugManagement(current.id)));
                        },
                      ),
                    ),
                  ],
        refresh: fetch);
  }
}
