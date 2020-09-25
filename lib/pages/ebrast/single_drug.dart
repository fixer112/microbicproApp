import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/medicines/medicines.dart';
import 'package:microbicpro/pages/pathogens/anti_biogram_data.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../values.dart';

class SingleDrug extends StatefulWidget {
  final int id;

  @override
  _SingleDrugState createState() => _SingleDrugState();
  SingleDrug(this.id);
}

class _SingleDrugState extends State<SingleDrug> {
  Medicine medicine;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    medicine = main.medicines
        .firstWhere((medicine) => medicine.id == widget.id, orElse: () => null);
    if (medicine == null) {
      Get.to(Medicines());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Pager(
      'Amoxycillin',
      [
        Widgets.header('ANTIMICROBIAL SPECTRUM'),
        Card(
          child: ListTile(
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
                                  'per': 79,
                                  'isno': 3,
                                },
                                {
                                  'title': 'Something',
                                  'per': 29,
                                  'isno': 5,
                                }
                              ],
                            },
                            {
                              'title': 'URINE ONLY',
                              'content': [
                                {
                                  'title': 'Something',
                                  'per': 59,
                                  'isno': 5,
                                },
                                {
                                  'title': 'Something',
                                  'per': 89,
                                  'isno': 5,
                                }
                              ],
                            }
                          ])));
            },
            trailing: Icon(
              FontAwesomeIcons.chevronCircleRight,
              color: primaryColor,
              size: 16,
            ),
            title: Widgets.text('Antibiogram data', weight: FontWeight.w500),
          ),
        ),
        Widgets.header('PHARMACOLOGY'),
        Widgets.collapsible('Drug class', []),
        Widgets.collapsible('Mechanism of action', []),
        Widgets.collapsible('Pharmacokinetics', []),
        Widgets.collapsible('Significant interactions', []),
        Widgets.collapsible('Pregnancy category', []),
        Widgets.collapsible('Contraindications', []),
        Widgets.collapsible('Adverse effects', []),
        Widgets.header('DOSE SCHEDULE'),
        Widgets.collapsible('Renal', []),
        Widgets.collapsible('Adult', []),
        Widgets.collapsible('Child', []),
      ],
      search: false,
    );
  }
}
