import 'package:flutter/material.dart';
import 'package:microbicpro/pages/pathogens/anti_biogram_data.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class EachPathogen extends StatefulWidget {
  @override
  _EachPathogenState createState() => _EachPathogenState();
}

class _EachPathogenState extends State<EachPathogen> {
  @override
  Widget build(BuildContext context) {
    return Pager(
      'Pathogen Title',
      [
        Widgets.header('General Information'),
        Widgets.collapsible('Overview', []),
        Widgets.collapsible('Epidermology', []),
        Widgets.collapsible('Diseases', []),
        Widgets.header('Anti-Microbial Spectrum'),
        Card(
          child: ListTile(
            title: Widgets.text('Ideal Spectrum', size: 17),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
            onTap: () {},
          ),
        ),
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
                          AntiBiogramData(title: 'Pathogen Title', content: [
                            {
                              'title': 'MIXED ISOLATE',
                              'content': [
                                {
                                  'title': 'Something',
                                  'per': 89,
                                  'isno': 5,
                                },
                                {
                                  'title': 'Something',
                                  'per': 49,
                                  'isno': 5,
                                }
                              ],
                            },
                            {
                              'title': 'URINE ONLY',
                              'content': [
                                {
                                  'title': 'Something',
                                  'per': 50,
                                  'isno': 5,
                                },
                                {
                                  'title': 'Something',
                                  'per': 69,
                                  'isno': 5,
                                }
                              ],
                            }
                          ])));
            },
          ),
        ),
        Widgets.header('Infection Control'),
        Widgets.collapsible('Precautions', []),
      ],
    );
  }
}
