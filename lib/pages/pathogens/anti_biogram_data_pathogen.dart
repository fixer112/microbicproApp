import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/PathogenAntibiogramData.dart';
import 'package:microbicpro/model/pathogen.dart';
import 'package:microbicpro/pages/ebrast/single_drug.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class AntiBiogramDataPathogen extends StatefulWidget {
  final Pathogen pathogen;

  const AntiBiogramDataPathogen(this.pathogen);

  @override
  _AntiBiogramDataState createState() => _AntiBiogramDataState();
}

class _AntiBiogramDataState extends State<AntiBiogramDataPathogen> {
  @override
  Widget build(BuildContext context) {
    Pathogen pathogen = widget.pathogen;
    List<PathogenAntibiogramData> antiBiogramDatas = pathogen.antibiogramDatas;
    //var main = Provider.of<MainModel>(context, listen: false);
    var samples = antiBiogramDatas
        .map((e) {
          return e.sample;

          //return if e.id > 0 ? e.id: ;
        })
        .toList()
        .toSet()
        .toList();
    return Pager(
      '${pathogen.name} Antibiogram Data',
      [
        SizedBox(
          height: 10,
        ),
        Widgets.text('ANTIBIOGRAM DATA',
            size: 20, align: TextAlign.center, weight: FontWeight.bold),
        SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(samples.length, (inx) {
            var datas = antiBiogramDatas
                .where((data) => data.sample == samples[inx])
                .toList();
            //var antiBiogramData = antiBiogramDatas[inx];
            //print(antiBiogramData.sample);
            var children = <Widget>[];
            children.add(Widgets.header(samples[inx].toUpperCase()));

            //print(medicine);

            datas.forEach((antiBiogramData) {
              //print(antiBiogramDatas[inx].);

              children.add(Container(
                child: InkWell(
                  onTap: () => Get.to(SingleDrug(antiBiogramData.medicineId)),
                  child: Card(
                    child: ListTile(
                        dense: true,
                        title: Widgets.text(antiBiogramData.medicineName,
                            size: 18,
                            color: getColor(double.parse(
                                antiBiogramData.percentage.toString()))),
                        subtitle: Widgets.text(
                            'isno: ${antiBiogramData.isolateNumber}',
                            size: 15,
                            color: getColor(double.parse(
                                antiBiogramData.percentage.toString()))),
                        trailing: Widgets.text(
                          '${antiBiogramData.percentage}%',
                          size: 16,
                          color: getColor(double.parse(
                              antiBiogramData.percentage.toString())),
                        )),
                  ),
                ),
              ));
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            );
          }),
        ),
      ],
      search: false,
    );
  }
}
