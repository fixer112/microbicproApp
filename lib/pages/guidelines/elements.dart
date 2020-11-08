import 'package:flutter/material.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Elements extends StatefulWidget {
  Elements({Key key}) : super(key: key);

  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<Elements> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var main = Provider.of<MainModel>(context, listen: false);
    return Pager(
      'Elements of AMS Interventions',
      [
        Container(
          child: Widgets.text(main.getUser.settings['element'], size: 17),
        ),
      ],
      //refresh: ()=> login(data, context),
    );
  }
}
