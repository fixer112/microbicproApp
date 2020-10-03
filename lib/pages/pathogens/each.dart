import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/pages/guidelines/disease/single.dart';
import 'package:microbicpro/pages/pathogens/anti_biogram_data_pathogen.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EachPathogen extends StatefulWidget {
  final int id;
  EachPathogen(this.id);
  @override
  _EachPathogenState createState() => _EachPathogenState();
}

class _EachPathogenState extends State<EachPathogen> {
  Pathogen pathogen;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    main.getPathogens().then((value) {
      pathogen = value.firstWhere((pathogen) => pathogen.id == widget.id,
          orElse: () => null);
      setState(() {});
      if (pathogen == null) {
        fetch();
        // Widgets.snackbar('Pathogen not found');
        // Get.to(Pathogens());
      }
    });
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    pathogen = await getPathogen(widget.id, context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(pathogen.precautions);
    return Pager(
        pathogen == null ? 'Pathogen Not Found' : "Pathogen - ${pathogen.name}",
        loading
            ? [Widgets.loader()]
            : pathogen == null
                ? [Widgets.centerText('Pathogen Not Found', context)]
                : [
                    Widgets.header('General Information'),
                    Widgets.collapsible('Overview', [
                      Widgets.text(pathogen.overview),
                    ]),
                    Widgets.collapsible('Epidermology', [
                      Widgets.text(pathogen.epidemiology),
                    ]),
                    Widgets.collapsible('Diseases', [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pathogen.diseases
                            .map((disease) => InkWell(
                                  onTap: () =>
                                      Get.to(SingleDisease(disease['id'])),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(disease['name']),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ]),
                    Widgets.header('Anti-Microbial Spectrum'),
                    Widgets.collapsible('Ideal Spectrum', [
                      Widgets.text(pathogen.spectrum),
                    ]),
                    Card(
                      child: ListTile(
                        title: Widgets.text('Antibiogram Data', size: 17),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AntiBiogramDataPathogen(pathogen)));
                        },
                      ),
                    ),
                    Widgets.header('Infection Control'),
                    Widgets.collapsible('Precautions', [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pathogen.precautions
                            .map((precausion) => InkWell(
                                  onTap: () =>
                                      Get.to(SingleDisease(precausion['id'])),
                                  child: Text("- ${precausion['description']}"),
                                ))
                            .toList(),
                      ),
                    ]),
                  ],
        refresh: () => fetch());
  }
}
