import 'package:flutter/material.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Elements extends StatefulWidget {
  const Elements({super.key});

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
    final main = Provider.of<MainModel>(context, listen: false);
    final user = main.getUser;
    final content =
        user?.settings['element']?.toString() ?? 'No data available';
    return Pager(
      'Elements of AMS Interventions',
      [
        Container(
          child: Widgets.text(content, size: 17),
        ),
      ],
      //refresh: ()=> login(data, context),
    );
  }
}
