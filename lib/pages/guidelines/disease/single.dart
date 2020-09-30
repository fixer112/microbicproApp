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
  @override
  _SingleDiseaseState createState() => _SingleDiseaseState();
  SingleDisease(this.id);
}

class _SingleDiseaseState extends State<SingleDisease> {
  Disease disease;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    disease = main.diseases
        .firstWhere((disease) => disease.id == widget.id, orElse: () => null);
    if (disease == null) {
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
    return Pager(
        disease == null ? 'Disease Not Found' : "Disease - ${disease.name}",
        loading
            ? [Widgets.loader()]
            : disease == null
                ? [Widgets.centerText('Disease Not Found', context)]
                : [
                    Widgets.collapsible(
                        'Overview', [Widgets.text(disease.overview)]),
                    Widgets.collapsible(
                        'Clinical Features', [Widgets.text(disease.features)]),
                    Widgets.collapsible('Treatment Objectives',
                        [Widgets.text(disease.treatmentObjectives)]),
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
                                      DrugManagement(disease.id)));
                        },
                      ),
                    ),
                  ],
        refresh: () => fetch());
  }
}
