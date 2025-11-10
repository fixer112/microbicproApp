import 'package:flutter/material.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Principles extends StatefulWidget {
  const Principles({super.key});

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
    final main = Provider.of<MainModel>(context, listen: false);
    final user = main.getUser;
    final content =
        user?.settings['principle']?.toString() ?? 'No data available';
    return Pager(
      'Principles of Antimicrobial Stewardship',
      [
        Container(
          child: Widgets.text(content, size: 17),
        ),
      ],
      //refresh: ()=> login(data, context),
    );
  }
}
