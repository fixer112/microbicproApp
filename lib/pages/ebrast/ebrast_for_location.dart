import 'package:flutter/material.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/model/Ebrast.dart';
import 'package:microbicpro/pages/ebrast/antibiotics.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EbrastLocation extends StatefulWidget {
  final String location;
  EbrastLocation(this.location);
  @override
  _EbrastLocationState createState() => _EbrastLocationState();
}

class _EbrastLocationState extends State<EbrastLocation> {
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
    await getEbrasts(context, location: widget.location);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Widgets.loader()
        : Consumer<MainModel>(builder: (context, main, child) {
            List<Ebrast> ebrasts = main.ebrasts
                .where((element) => element.location == widget.location)
                .toList()
                .toSet()
                .toList();

            return Pager(
              'Ebrast: ${widget.location.toUpperCase()}',
              ebrasts.isEmpty
                  ? [Widgets.centerText('No Medicine Available', context)]
                  : [
                      SizedBox(
                        height: 30,
                      ),
                      Widgets.text('Select Sample Type',
                          size: 20,
                          align: TextAlign.center,
                          weight: FontWeight.bold),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: List.generate(ebrasts.length, (index) {
                          return Card(
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              title: Widgets.text(
                                  ebrasts[index].sample.toUpperCase(),
                                  size: 17,
                                  weight: FontWeight.w400),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AntiBiotics(ebrasts[index].id),
                                    ));
                              },
                            ),
                          );
                        }),
                      ),
                    ],
              refresh: () => fetch(),
            );
          });
  }
}
