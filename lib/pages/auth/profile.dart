import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  User user;
  @override
  void initState() {
    super.initState();
    var main = Provider.of<MainModel>(context, listen: false);
    main.getUser().then((value) => user = value);
  }

  @override
  Widget build(BuildContext context) {
    return Pager(
      'Profile',
      [
        Container(
          child: Column(
            children: [
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
        )
      ],
      bottomBarIndex: 4,
    );
  }
}
