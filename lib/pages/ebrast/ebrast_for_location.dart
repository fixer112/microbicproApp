import 'package:flutter/material.dart';
import 'package:microbicpro/pages/ebrast/antibiotics.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

class EbrastLocation extends StatefulWidget {
  @override
  _EbrastLocationState createState() => _EbrastLocationState();
}

class _EbrastLocationState extends State<EbrastLocation> {
  @override
  Widget build(BuildContext context) {
    return Pager('Ebrast: Lagos', [
      SizedBox(height: 30,),
      Widgets.text('Select Sample Type', size: 20, align: TextAlign.center, weight: FontWeight.bold),
      SizedBox(height: 30,),

      Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Widgets.text('Blood', size: 17, weight: FontWeight.w400),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AntiBiotics(),));
          },
        ),
      ),

      Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Widgets.text('Conjuctival Specimen', size: 17, weight: FontWeight.w400),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AntiBiotics(),));
          },
        ),
      ),

      Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Widgets.text('Ear Swab', size: 17, weight: FontWeight.w400),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AntiBiotics(),));
          },
        ),
      ),

      Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Widgets.text('Skin Swab', size: 17, weight: FontWeight.w400),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AntiBiotics(),));
          },
        ),
      ),

      Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          title: Widgets.text('Sputum', size: 17, weight: FontWeight.w400),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AntiBiotics(),));
          },
        ),
      ),
    ], search: false,);
  }
}