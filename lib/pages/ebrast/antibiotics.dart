import 'package:flutter/material.dart';
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
  const AntiBiotics(this.id, {super.key});
  @override
  _AntiBioticsState createState() => _AntiBioticsState();
}

class _AntiBioticsState extends State<AntiBiotics> {
  Ebrast? ebrast;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    final main = Provider.of<MainModel>(context, listen: false);
    final matches = main.getEbrasts.where((ebrast) => ebrast.id == widget.id);
    ebrast = matches.isNotEmpty ? matches.first : null;
    if (ebrast == null) {
      fetch();
      // Widgets.snackbar('Ebrast not found');
      // Get.to(Ebrasts());
    }
  }

  Future<void> fetch() async {
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
    final current = ebrast;
    final medicines = current == null
        ? <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(current.medicines);
    medicines.sort(
      (b, a) => a['pivot']['ebrast_number']
          .toString()
          .compareTo(b['pivot']['ebrast_number'].toString()),
    );
    return Pager(
      current == null
          ? 'Ebrast Not Found'
          : 'Ebrast: ${current.location} (${current.sample})',
      loading
          ? [Widgets.loader()]
          : current == null
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
                        'ASSOCIATED DISEASES\n${current.diseases}',
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
                    children: List.generate(medicines.length, (index) {
                      final medicine = medicines[index];
                      final numberString =
                          medicine['pivot']['ebrast_number'].toString();
                      final ebrastNumber = double.tryParse(numberString) ?? 0;
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SingleDrug(medicine['id'])));
                          },
                          /*  leading:
                              /* Icon(
                            FontAwesomeIcons.squareFull,
                            color: getColor(ebrastNumber),
                            size: 16,
                          ) */
                              //Widgets.iconImage('medicines.png'), */
                          title: Row(
                            children: [
                              Widgets.text(medicine['name'],
                                  color: getColor(ebrastNumber)),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              //Widgets.iconImage('medicines.png'),
                            ],
                          ),
                          trailing: Widgets.text(
                              "$ebrastNumber${medicine['type'][0].toUpperCase()}",
                              weight: FontWeight.w600,
                              color: getColor(ebrastNumber)),
                        ),
                      );
                    }),
                  ),
                ],
      refresh: fetch,
    );
  }
}
