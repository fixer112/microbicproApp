import 'package:flutter/material.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class DrugManagement extends StatefulWidget {
  @override
  _DrugManagementState createState() => _DrugManagementState();
}

class _DrugManagementState extends State<DrugManagement> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Otitis Media (Acute)'),
          bottom: TabBar(
            isScrollable: true,
            onTap: (int) {},
            tabs: [
              Tab(
                text: 'Non-purulent',
              ),
              Tab(
                text: 'Purulent',
              ),
              Tab(
                text: 'Mild',
              ),
              Tab(
                text: 'Moderate',
              ),
              Tab(
                text: 'Severe',
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: TabBarView(
            children: List.generate(
                5,
                (index) => ListView(
                      children: [
                        Widgets.header('ADULTS'),
                        Widgets.collapsible('AntiBiotics', [
                          Column(
                            children: [
                              Widgets.collapsible('Alternative 1', [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Ceftriaxone 1g 12 hourly for 7days'),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Amoxillin 1g 8 hourly for 14days'),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              Widgets.collapsible('Alternative 2', [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Ceftriaxone 1g 12 hourly for 7days'),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Amoxillin 1g 8 hourly for 14days'),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ],
                          )
                        ]),
                        Widgets.collapsible('AntiFungal', [
                          Column(
                            children: [
                              Widgets.collapsible('Alternative 1', [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Ceftriaxone 1g 12 hourly for 7days'),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Amoxillin 1g 8 hourly for 14days'),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              Widgets.collapsible('Alternative 2', [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Ceftriaxone 1g 12 hourly for 7days'),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Amoxillin 1g 8 hourly for 14days'),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ],
                          )
                        ]),
                        Widgets.header('CHILDREN'),
                        Widgets.collapsible('AntiBiotics', [
                          Column(
                            children: [
                              Widgets.collapsible('Alternative 1', [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Ceftriaxone 1g 12 hourly for 7days'),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Amoxillin 1g 8 hourly for 14days'),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              Widgets.collapsible('Alternative 2', [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Ceftriaxone 1g 12 hourly for 7days'),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Widgets.text(
                                            'Amoxillin 1g 8 hourly for 14days'),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ],
                          )
                        ]),
                      ],
                    )),
          ),
        ),
      ),
    );
  }
}
