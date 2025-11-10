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

class EachPathogen extends StatefulWidget {
  final int id;
  const EachPathogen(this.id, {super.key});
  @override
  State<EachPathogen> createState() => _EachPathogenState();
}

class _EachPathogenState extends State<EachPathogen> {
  Pathogen? pathogen;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    final matches =
        main.getPathogens.where((pathogen) => pathogen.id == widget.id);
    pathogen = matches.isNotEmpty ? matches.first : null;
    if (pathogen == null) {
      fetch();
    }
  }

  Future<void> fetch() async {
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
    final current = pathogen;
    //print(pathogen.precautions);
    return Pager(
        current == null ? 'Pathogen Not Found' : "Pathogen - ${current.name}",
        loading
            ? [Widgets.loader()]
            : current == null
                ? [Widgets.centerText('Pathogen Not Found', context)]
                : [
                    Widgets.header('General Information',
                        icon: 'pathogen_info.png'),
                    Widgets.collapsible('Overview', [
                      Widgets.text(current.overview),
                    ]),
                    Widgets.collapsible('Epidemiology', [
                      Widgets.text(current.epidemiology),
                    ]),
                    Widgets.collapsible('Diseases', [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: current.diseases
                            .map((disease) => InkWell(
                                  onTap: () => Get.to(
                                      () => SingleDisease(disease['id'])),
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
                    Widgets.collapsible(
                        'Ideal Spectrum',
                        [
                          Widgets.text(current.spectrum),
                        ],
                        icon: 'general_spectrum.png',
                        width: 20,
                        height: 20),
                    Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Widgets.text('Antibiogram Data', size: 17),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AntiBiogramDataPathogen(current)));
                        },
                      ),
                    ),
                    Widgets.header('Infection Control'),
                    Widgets.collapsible('Precautions', [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: current.precautions
                            .map((precausion) => InkWell(
                                  onTap: () => Get.to(
                                      () => SingleDisease(precausion['id'])),
                                  child: Text("- ${precausion['description']}"),
                                ))
                            .toList(),
                      ),
                    ]),
                  ],
        refresh: fetch);
  }
}
