import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/Ebrast.dart' as EbrastModel;
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/pages/ebrast/ebrast.dart';
import 'package:microbicpro/pages/guidelines/guidelines.dart';
import 'package:microbicpro/pages/medicines/medicines.dart';
import 'package:microbicpro/pages/pathogens/pathogens.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../functions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      loading = true;
    });
    var main = Provider.of<MainModel>(context, listen: false);
    try {
      var pData = await getJson(fileName: 'pathogens.json');
      //print(pData);

      if (pData != null) {
        pData = jsonDecode(pData);
        //print(pData[0]);

        List<Pathogen> pathogens =
            List<Pathogen>.from(pData.map((i) => Pathogen.fromMap((i))))
                .toList();
        //print(pathogens);
        main.setPathogens(pathogens);
      }

      var mData = await getJson(fileName: 'medicines.json');
      if (mData != null) {
        mData = jsonDecode(mData);
        List<Medicine> medicines =
            List<Medicine>.from(mData.map((i) => Medicine.fromMap(i))).toList();
        main.setMedicines(medicines);
      }

      var dData = await getJson(fileName: 'diseases.json');
      if (dData != null) {
        dData = jsonDecode(dData);

        List<Disease> diseases =
            List<Disease>.from(dData.map((i) => Disease.fromMap(i))).toList();
        main.setDiseases(diseases);
      }

      var eData = await getJson(fileName: 'ebrasts.json');
      if (dData != null) {
        eData = jsonDecode(eData);
        //print(eData);
        List<EbrastModel.Ebrast> ebrasts = List<EbrastModel.Ebrast>.from(
            eData.map((i) => EbrastModel.Ebrast.fromMap(i))).toList();
        main.setEbrasts(ebrasts);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //double center = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: loading
              ? Widgets.loader()
              : GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(vertical: 50),
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Widgets.gradienticon(
                              FontAwesomeIcons.checkSquare,
                              50,
                              LinearGradient(
                                colors: <Color>[
                                  Colors.orange,
                                  Colors.pink,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Widgets.text('Guidelines',
                              size: 23,
                              color: Colors.pink,
                              weight: FontWeight.w600)
                        ],
                      ),
                      onTap: () {
                        Get.to(Guidelines());
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Widgets.gradienticon(
                              FontAwesomeIcons.disease,
                              50,
                              LinearGradient(
                                colors: <Color>[
                                  Colors.green,
                                  Colors.blue,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Widgets.text('Pathogens',
                              size: 23,
                              color: Colors.blue,
                              weight: FontWeight.w600)
                        ],
                      ),
                      onTap: () => Get.to(Pathogens()),
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Widgets.gradienticon(
                              FontAwesomeIcons.bookMedical,
                              50,
                              LinearGradient(
                                colors: <Color>[
                                  Colors.indigo,
                                  Colors.purple,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Widgets.text('Medicines',
                              size: 23,
                              color: Colors.purple,
                              weight: FontWeight.w600)
                        ],
                      ),
                      onTap: () {
                        Get.to(Medicines());
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Widgets.gradienticon(
                              FontAwesomeIcons.questionCircle,
                              50,
                              LinearGradient(
                                colors: <Color>[
                                  Colors.red,
                                  Colors.brown,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Widgets.text('Ebrast',
                              size: 23,
                              color: Colors.brown,
                              weight: FontWeight.w600)
                        ],
                      ),
                      onTap: () {
                        Get.to(Ebrast());
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
