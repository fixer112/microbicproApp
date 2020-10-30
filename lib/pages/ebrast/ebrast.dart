import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/pages/ebrast/ebrast_for_location.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Ebrast extends StatefulWidget {
  @override
  _EbrastState createState() => _EbrastState();
}

class _EbrastState extends State<Ebrast> {
  String _location;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);

    if (main.ebrasts.isEmpty) {
      fetch();
    }
  }

  fetch() async {
    setState(() {
      loading = true;
    });

    await getEbrasts(context);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Widgets.loader()
        : Consumer<MainModel>(builder: (context, main, child) {
            List<String> locationList =
                main.ebrasts.map((e) => e.location).toList();
            locationList.sort();
            List<DropdownMenuItem<String>> locations = List.generate(
              locationList.length,
              (index) => DropdownMenuItem(
                child: Text(locationList[index].toUpperCase()),
                value: locationList[index],
              ),
            );
            return Pager(
              'Ebrast',
              [
                SizedBox(
                  height: 30,
                ),
                Widgets.text('EVIDENCE BASED RAPID ANTIBIOTIC SELECTION TOOL',
                    size: 20, align: TextAlign.center, weight: FontWeight.bold),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffbee5eb)),
                    color: Color(0xffd1ecf1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Widgets.text(
                      'THIS DECISION SUPPORT TOOL IS BASED ON ANTIBIOTIC SUSCEPTIBILITY OF PATHOGENS AND THEIR PREVALENCE',
                      size: 16,
                      color: Color(0xff0c5460)),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: DropdownButton(
                      value: _location,
                      items: locations,
                      hint: Widgets.text('Select Location',
                          weight: FontWeight.bold),
                      icon: Icon(
                        FontAwesomeIcons.chevronDown,
                        size: 20,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          _location = val;
                          print(val);
                        });
                        Get.to(EbrastLocation(val));
                        return;
                      },
                    ),
                  ),
                ),
              ],
              bottomBarIndex: 3,
              refresh: () => fetch(),
            );
          });
  }
}
