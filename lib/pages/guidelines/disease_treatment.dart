import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/model/disease.dart';
import 'package:microbicpro/pages/guidelines/disease/single.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DiseaseTreatment extends StatefulWidget {
  @override
  _DiseaseTreatmentState createState() => _DiseaseTreatmentState();
}

class _DiseaseTreatmentState extends State<DiseaseTreatment> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    if (main.diseases.isEmpty) {
      fetch();
    }
  }

  fetch() async {
    setState(() {
      loading = true;
    });
    await getDiseases(context);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Widgets.loader()
        : Consumer<MainModel>(builder: (context, main, child) {
            var diseases = main.diseases;
            diseases.sort((a, b) => a.name.compareTo(b.name));
            List<String> categories =
                diseases.map((e) => e.category).toList().toSet().toList();
            categories.sort((a, b) => a.compareTo(b));

            return Pager(
              'Disease Treatment Guidelines',
              diseases.isEmpty
                  ? [Widgets.centerText('No Disease Available', context)]
                  : List.generate(categories.length, (index) {
                      List<Disease> catDiseases = diseases
                          .where((element) =>
                              element.category == categories[index])
                          .toList();

                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Widgets.header(categories[index].toUpperCase()),
                            Column(
                              children:
                                  List.generate(catDiseases.length, (index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () => Get.to(
                                          SingleDisease(catDiseases[index].id)),
                                      child: Card(
                                        child: ListTile(
                                          title: Widgets.text(
                                              catDiseases[index].name,
                                              weight: FontWeight.w600),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ]);
                    }),
              search: false,
              refresh: () => fetch(),
            );
          });
  }
}
