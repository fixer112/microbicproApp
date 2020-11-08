import 'package:flutter/material.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Principles extends StatefulWidget {
  Principles({Key key}) : super(key: key);

  @override
  _PrinciplesState createState() => _PrinciplesState();
}

class _PrinciplesState extends State<Principles> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var main = Provider.of<MainModel>(context, listen: false);
    return Pager(
      'Principles of Antimicrobial Stewardship',
      [
        Container(
          child: Widgets.text(main.getUser.settings['principle'], size: 17),
        ),
      ],
      //refresh: ()=> login(data, context),
    );
  }
}
