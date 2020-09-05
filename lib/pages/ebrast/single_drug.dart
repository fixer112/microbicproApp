import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microbicpro/pages/pathogens/anti_biogram_data.dart';
import 'package:microbicpro/widgets/page.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../../values.dart';

class SingleDrug extends StatefulWidget {
  @override
  _SingleDrugState createState() => _SingleDrugState();
}

class _SingleDrugState extends State<SingleDrug> {
  @override
  Widget build(BuildContext context) {
    return Pager('Amoxycillin', [

      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffbee5eb)),
          color: Color(0xffd1ecf1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Widgets.text('W.H.O recommended Access Antibiotic', size: 16, color: Color(0xff0c5460)),
      ),

      Card(
        child: ListTile(
          onTap: (){
          },
          trailing: Icon( FontAwesomeIcons.chevronCircleRight, color: primaryColor, size: 16, ),
          title: Widgets.text('Antimicrobial Spectrum', weight: FontWeight.w500),
        ),
      ),

      Card(
        child: ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => AntiBiogramData( title: 'Pathogen Title', content: [{
                'title': 'MIXED ISOLATE',
                'content': [
                  {
                    'title': 'Something',
                    'per': 29,
                    'isno': 5,
                  },
                  {
                    'title': 'Something',
                    'per': 29,
                    'isno': 5,
                  }
                ],
              }, {
                'title': 'URINE ONLY',
                'content': [
                  {
                    'title': 'Something',
                    'per': 29,
                    'isno': 5,
                  },
                  {
                    'title': 'Something',
                    'per': 29,
                    'isno': 5,
                  }
                ],
              }])
            ));
          },
          trailing: Icon( FontAwesomeIcons.chevronCircleRight, color: primaryColor, size: 16, ),
          title: Widgets.text('Antibiogram data', weight: FontWeight.w500),
        ),
      ),

      Card(
        child: ListTile(
          onTap: (){
          },
          trailing: Icon( FontAwesomeIcons.chevronCircleRight, color: primaryColor, size: 16, ),
          title: Widgets.text('General Spectrum', weight: FontWeight.w500),
        ),
      ),

      Card(
        child: ListTile(
          onTap: (){
          },
          trailing: Icon( FontAwesomeIcons.chevronCircleRight, color: primaryColor, size: 16, ),
          title: Widgets.text('Pharmacology', weight: FontWeight.w500),
        ),
      ),

      Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
        color: Colors.orange,
        padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Widgets.text('DOSAGE'),
      ),
    ], search: false,);
  }
}