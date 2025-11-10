import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../functions.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

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
          final user = main.getUser;
          if (user == null) {
            return Widgets.centerText('No profile available', context);
          }

          Future<void> location() async {
            String? selectedLocation;
            bool loading = false;

            final locationsData =
                List<String>.from(user.settings['locations'] ?? const []);
            locationsData.sort();
            final locations = locationsData
                .map(
                  (loc) => DropdownMenuItem<String>(
                    value: loc,
                    child: Text(loc.toUpperCase()),
                  ),
                )
                .toList();

            final hospitals =
                List<String>.from(user.settings['hospitals'] ?? const []);
            if (!hospitals.contains(user.location)) {
              final sheet = StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Card(
                            child: DropdownButton<String>(
                              value: selectedLocation,
                              items: locations,
                              hint: Widgets.text('Select Location',
                                  weight: FontWeight.bold),
                              icon: const Icon(
                                FontAwesomeIcons.chevronDown,
                                size: 20,
                              ),
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (val) {
                                setState(() {
                                  selectedLocation = val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          loading
                              ? Widgets.loader()
                              : Widgets.button('Change Location', () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await changeLocation(
                                      selectedLocation, context);
                                  final data = await getJson();
                                  if (data != null) {
                                    await login(jsonDecode(data), context,
                                        refresh: true);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                }),
                        ],
                      ),
                    ),
                  );
                },
              );
              Get.bottomSheet(sheet, backgroundColor: Colors.white);
            }
          }

          return Column(
            children: [
              InkWell(
                onTap: location,
                child: Card(
                  child: ListTile(
                    title: Widgets.text(
                        'Location (${user.location.toUpperCase()})'),
                    trailing: const Icon(FontAwesomeIcons.locationArrow),
                  ),
                ),
              ),
              InkWell(
                onTap: () => logout(),
                child: Card(
                  child: ListTile(
                    title: Widgets.text('Logout', color: Colors.red),
                    trailing: const Icon(FontAwesomeIcons.powerOff,
                        color: Colors.red),
                  ),
                ),
              ),
            ],
          );
        })
      ],
      bottomBarIndex: 4,
    );
  }
}
