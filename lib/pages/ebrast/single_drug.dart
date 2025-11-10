import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/medicines/anti_biogram_data_medicine.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../values.dart';

class SingleDrug extends StatefulWidget {
  final int id;
  const SingleDrug(this.id, {super.key});

  @override
  State<SingleDrug> createState() => _SingleDrugState();
}

class _SingleDrugState extends State<SingleDrug> {
  Medicine? medicine;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    final main = Provider.of<MainModel>(context, listen: false);
    final matches =
        main.medicines.where((medicine) => medicine.id == widget.id);
    medicine = matches.isNotEmpty ? matches.first : null;
    if (medicine == null) {
      fetch();
      // Widgets.snackbar('Medicine not found');
      // Future.delayed(Duration(seconds: 1), () => Get.to(Medicines()));
    }
  }

  Future<void> fetch() async {
    setState(() {
      loading = true;
    });
    medicine = await getMedicine(widget.id, context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = medicine;
    return Pager(
      current == null ? 'Medicine Not Found' : "Medicine - ${current.name}",
      loading
          ? [Widgets.loader()]
          : current == null
              ? [Widgets.centerText('Medicine Not Found', context)]
              : [
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Widgets.text(
                            "W.H.O recommended ${current.type.toUpperCase()} antibiotic",
                            color: Colors.white,
                            size: 15,
                            weight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: getTypeColor(current.type),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  Widgets.header('ANTIMICROBIAL SPECTRUM'),
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
                      onTap: () {
                        Get.to(() => AntiBiogramDataMedicine(current));
                      },
                      trailing: Icon(
                        FontAwesomeIcons.circleChevronRight,
                        color: primaryColor,
                        size: 16,
                      ),
                      title: Row(
                        children: [
                          //Widgets.iconImage('antibiogram_data.png'),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          Widgets.text('Antibiogram data',
                              weight: FontWeight.w500),
                        ],
                      ),
                      //leading: Widgets.iconImage('antibiogram_data.png'),
                    ),
                  ),
                  Widgets.header('PHARMACOLOGY', icon: 'pharmacology.png'),
                  Widgets.collapsible(
                      'Drug class',
                      [
                        Widgets.text(current.drugClass),
                      ],
                      icon: 'drug_class.png'),
                  Widgets.collapsible(
                      'Mechanism of action',
                      [
                        Widgets.text(current.action),
                      ],
                      icon: 'mechanism_of_action.png'),
                  Widgets.collapsible('Pharmacokinetics', [
                    Widgets.text(current.pharmacokinetics),
                  ]),
                  Widgets.collapsible('Significant interactions', [
                    Widgets.text(current.interactions),
                  ]),
                  Widgets.collapsible(
                      'Pregnancy category',
                      [
                        Widgets.text(current.pregnancyCategory),
                      ],
                      icon: 'pregnancy.png'),
                  /*  Widgets.collapsible('Contraindications', [
                Widgets.text(medicine.drugClass),
              ]), */
                  Widgets.collapsible(
                      'Adverse effects',
                      [
                        Widgets.text(current.adverseEffects),
                      ],
                      icon: 'adverse_effect.png'),
                  Widgets.header('DOSE SCHEDULE', icon: 'dose.png'),
                  Widgets.collapsible(
                      'Renal',
                      [
                        Widgets.text(current.renal),
                      ],
                      icon: 'renal.png'),
                  Widgets.collapsible(
                      'Adult',
                      [
                        Widgets.text(current.adult),
                      ],
                      icon: 'adult.png'),
                  Widgets.collapsible('Child', [
                    Widgets.text(current.child),
                  ]),
                ],
      search: false,
      refresh: fetch,
    );
  }

  /* Color getTypeColor(String type) {
    if (type == 'reserve') {
      return Colors.red;
    }
    if (type == 'access') {
      return Colors.green;
    }

    if (type == 'watch') {
      return Colors.yellow[600];
    }

    return Colors.blue;
  } */
}
