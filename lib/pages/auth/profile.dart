import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/model/user.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../functions.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Pager(
      'Profile',
      [
        Consumer<MainModel>(builder: (context, main, child) {
          User user = main.getUser;
          location() async {
            bool loading = false;

            String _location = user.location;
            var locationList = user.settings['locations'];
            locationList.sort();
            List<DropdownMenuItem<String>> locations = List.generate(
              locationList.length,
              (index) => DropdownMenuItem(
                child: Text(locationList[index].toUpperCase()),
                value: locationList[index],
              ),
            );
            if (!user.settings['hospitals'].contains(user.location)) {
              Widget widget = Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: 150,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Widgets.header('Change Location'),
                      Card(
                        //margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Container(
                          //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      loading
                          ? Widgets.loader()
                          : Widgets.button('Change Location', () async {
                              setState(() {
                                loading = true;
                              });
                              await changeLocation(_location, context);
                              setState(() {
                                loading = false;
                              });
                            }),
                    ],
                  ),
                ),
              );
              Get.bottomSheet(widget, backgroundColor: Colors.white);
            }
          }

          return Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () => location(),
                  child: Card(
                    child: ListTile(
                      title: Widgets.text(
                          'Location (${user.location.toUpperCase()})'),
                      trailing: Icon(FontAwesomeIcons.locationArrow),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => logout(),
                  child: Card(
                    child: ListTile(
                      title: Widgets.text('Logout', color: Colors.red),
                      trailing:
                          Icon(FontAwesomeIcons.powerOff, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          );
        })
      ],
      bottomBarIndex: 4,
    );
  }
}
