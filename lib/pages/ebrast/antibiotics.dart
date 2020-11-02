import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/Ebrast.dart';
import 'package:microbicpro/pages/ebrast/single_drug.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AntiBiotics extends StatefulWidget {
  final int id;
  AntiBiotics(this.id);
  @override
  _AntiBioticsState createState() => _AntiBioticsState();
}

class _AntiBioticsState extends State<AntiBiotics> {
  Ebrast ebrast;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    ebrast = main.getEbrasts
        .firstWhere((ebrast) => ebrast.id == widget.id, orElse: () => null);
    if (ebrast == null) {
      fetch();
      // Widgets.snackbar('Ebrast not found');
      // Get.to(Ebrasts());
    }
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    ebrast = await getEbrast(widget.id, context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(ebrast.medicines[0]['pivot']);
    ebrast.medicines.sort((b, a) =>
        a['pivot']['ebrast_number'].compareTo(b['pivot']['ebrast_number']));
    return Pager(
      ebrast == null
          ? 'Ebrast Not Found'
          : 'Ebrast: ${ebrast.location} (${ebrast.sample})',
      loading
          ? [Widgets.loader()]
          : ebrast == null
              ? [Widgets.centerText('Ebrast Not Found', context)]
              : [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffbee5eb)),
                      color: Color(0xffd1ecf1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Widgets.text(
                        'ASSOCIATED DISEASES\n${ebrast.diseases}',
                        size: 16,
                        color: Color(0xff0c5460)),
                  ),
                  Widgets.text('ANTIBIOTIC RANKINGS',
                      size: 20,
                      align: TextAlign.center,
                      weight: FontWeight.bold),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: List.generate(ebrast.medicines.length, (index) {
                      var medicine = ebrast.medicines[index];
                      double ebrastNumber =
                          double.parse(medicine['pivot']['ebrast_number']);
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SingleDrug(medicine['id'])));
                          },
                          leading: Icon(
                            FontAwesomeIcons.squareFull,
                            color: getColor(ebrastNumber),
                            size: 16,
                          ),
                          title: Widgets.text(medicine['name'],
                              color: getColor(ebrastNumber)),
                          trailing: Widgets.text(
                              "$ebrastNumber${medicine['type'][0].toUpperCase()}",
                              weight: FontWeight.w600,
                              color: getColor(ebrastNumber)),
                        ),
                      );
                    }),
                  ),
                ],
      refresh: () => fetch(),
    );
  }
}
