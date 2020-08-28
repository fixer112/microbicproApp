import 'package:flutter/material.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class AntiBiogramData extends StatefulWidget {
  final String title;
  final dynamic content;

  const AntiBiogramData({Key key, this.title, this.content}) : super(key: key);

  @override
  _AntiBiogramDataState createState() => _AntiBiogramDataState();
}

class _AntiBiogramDataState extends State<AntiBiogramData> {
  @override
  Widget build(BuildContext context) {
    return Pager( widget.title, [
      SizedBox(height: 10,),
      Widgets.text('ANTIBIOGRAM DATA', size: 20, align: TextAlign.center, weight: FontWeight.bold),
      SizedBox(height: 20,),

      Column(
        children: List.generate(widget.content.length, (inx){
          var children = <Widget>[];
          children.add(
            Widgets.header( widget.content[inx]['title'] ));

          widget.content[inx]['content'].forEach((e){
            children.add(Container(
              child: Card(
                  child: ListTile(
                    dense: true,
                    title: Widgets.text(e['title']),
                    subtitle: Widgets.text('isno: ${e['isno']}', size: 12),
                    trailing: Widgets.text('${e['per']}%', size: 16),
                  ),
                ),
              ));
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }),
      ),
    ]);
  }
}