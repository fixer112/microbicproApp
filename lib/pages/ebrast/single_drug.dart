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

  @override
  _SingleDrugState createState() => _SingleDrugState();
  SingleDrug(this.id);
}

class _SingleDrugState extends State<SingleDrug> {
  Medicine medicine;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    medicine = main.medicines
        .firstWhere((medicine) => medicine.id == widget.id, orElse: () => null);
    if (medicine == null) {
      fetch();
      // Widgets.snackbar('Medicine not found');
      // Future.delayed(Duration(seconds: 1), () => Get.to(Medicines()));
    }
  }

  fetch() async {
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
    return Pager(
      medicine == null ? 'Medicine Not Found' : "Medicine - ${medicine.name}",
      loading
          ? [Widgets.loader()]
          : medicine == null
              ? [Widgets.centerText('Medicine Not Found', context)]
              : [
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Widgets.text(
                            "W.H.O recommended ${medicine.type.toUpperCase()} antibiotic",
                            color: Colors.white,
                            size: 15,
                            weight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: getTypeColor(medicine.type),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  Widgets.header('ANTIMICROBIAL SPECTRUM'),
                  Widgets.collapsible('Ideal Spectrum', [
                    Widgets.text(medicine.spectrum),
                  ]),
                  Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(AntiBiogramDataMedicine(medicine));
                      },
                      trailing: Icon(
                        FontAwesomeIcons.chevronCircleRight,
                        color: primaryColor,
                        size: 16,
                      ),
                      title: Widgets.text('Antibiogram data',
                          weight: FontWeight.w500),
                    ),
                  ),
                  Widgets.header('PHARMACOLOGY'),
                  Widgets.collapsible('Drug class', [
                    Widgets.text(medicine.drugClass),
                  ]),
                  Widgets.collapsible('Mechanism of action', [
                    Widgets.text(medicine.action),
                  ]),
                  Widgets.collapsible('Pharmacokinetics', [
                    Widgets.text(medicine.pharmacokinetics),
                  ]),
                  Widgets.collapsible('Significant interactions', [
                    Widgets.text(medicine.interactions),
                  ]),
                  Widgets.collapsible('Pregnancy category', [
                    Widgets.text(medicine.pregnancyCategory),
                  ]),
                  /*  Widgets.collapsible('Contraindications', [
                Widgets.text(medicine.drugClass),
              ]), */
                  Widgets.collapsible('Adverse effects', [
                    Widgets.text(medicine.adverseEffects),
                  ]),
                  Widgets.header('DOSE SCHEDULE'),
                  Widgets.collapsible('Renal', [
                    Widgets.text(medicine.renal),
                  ]),
                  Widgets.collapsible('Adult', [
                    Widgets.text(medicine.adult),
                  ]),
                  Widgets.collapsible('Child', [
                    Widgets.text(medicine.child),
                  ]),
                ],
      search: false,
      refresh: () => fetch(),
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
