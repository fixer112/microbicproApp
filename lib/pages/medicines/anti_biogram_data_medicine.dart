import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/model/MedicineAntiBiogramData.dart';
import 'package:microbicpro/model/medicine.dart';
import 'package:microbicpro/pages/ebrast/single_drug.dart';
import 'package:microbicpro/pages/pathogens/each.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AntiBiogramDataMedicine extends StatefulWidget {
  final Medicine medicine;

  const AntiBiogramDataMedicine(this.medicine);

  @override
  _AntiBiogramDataState createState() => _AntiBiogramDataState();
}

class _AntiBiogramDataState extends State<AntiBiogramDataMedicine> {
  @override
  Widget build(BuildContext context) {
    var main = Provider.of<MainModel>(context, listen: false);
    Medicine medicine = widget.medicine;

    List<MedicineAntiBiogramData> antiBiogramDatas = medicine.antibiogramDatas
        .where((element) => element.location == main.getUser.location)
        .toList();
    var samples = antiBiogramDatas
        .map((e) {
          return e.sample;

          //return if e.id > 0 ? e.id: ;
        })
        .toList()
        .toSet()
        .toList();
    return Pager(
      '${medicine.name} Antibiogram Data',
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
                  onTap: () => Get.to(EachPathogen(antiBiogramData.pathogenId)),
                  child: Card(
                    child: ListTile(
                        dense: true,
                        title: Widgets.text(antiBiogramData.pathogenName,
                            size: 18,
                            color: getColor(double.parse(
                                antiBiogramData.percentage.toString()))),
                        subtitle: Widgets.text(
                            'isno: ${antiBiogramData.isolateNumber}',
                            size: 15,
                            color: getColor(double.parse(
                                antiBiogramData.percentage.toString()))),
                        trailing: Column(
                          children: [
                            Widgets.text(
                              '${antiBiogramData.percentage}%',
                              size: 16,
                              color: getColor(double.parse(
                                  antiBiogramData.percentage.toString())),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Widgets.text('[${antiBiogramData.referenceID}]',
                                color: Colors.blue),
                          ],
                        )),
                  ),
                ),
              ));
              children.add(Widgets.header('REFERENCES'));
              children.add(
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  //color: primaryColor,
                  padding: EdgeInsets.all(20),
                  child: Widgets.text(medicine.reference, color: Colors.white),
                ),
              );
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

  Color getColor(double per) {
    if (per < 50) {
      return Colors.red;
    } else if (per > 70) {
      return Colors.green;
    }
    return Colors.yellow[600];
  }
}
