import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microbicpro/pages/ebrast/ebrast.dart';
import 'package:microbicpro/pages/guidelines/guidelines.dart';
import 'package:microbicpro/pages/medicines/medicines.dart';
import 'package:microbicpro/pages/pathogens/pathogens.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../values.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double center = MediaQuery.of(context).size.height/2;
    
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            shrinkWrap: true,
            children: [
              InkWell(
                child: Column(
                  children: [
                    Widgets.gradienticon(FontAwesomeIcons.checkSquare, 50, LinearGradient(
                      colors: <Color>[
                        Colors.orange,
                        Colors.pink,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    SizedBox(height: 5,),
                    Widgets.text('Guidelines', size: 23, color: Colors.pink, weight: FontWeight.w600)
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Guidelines()));
                },
              ),
              SizedBox(height: 60,),
              
              InkWell(
                child: Column(
                  children: [
                    Widgets.gradienticon(FontAwesomeIcons.disease, 50, LinearGradient(
                      colors: <Color>[
                        Colors.green,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    SizedBox(height: 5,),
                    Widgets.text('Pathogens', size: 23, color: Colors.blue, weight: FontWeight.w600)
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Pathogens()));
                },
              ),
              SizedBox(height: 60,),
              
              InkWell(
                child: Column(
                  children: [
                    Widgets.gradienticon(FontAwesomeIcons.bookMedical, 50, LinearGradient(
                      colors: <Color>[
                        Colors.indigo,
                        Colors.purple,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    SizedBox(height: 5,),
                    Widgets.text('Medicines', size: 23, color: Colors.purple, weight: FontWeight.w600)
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Medicines()));
                },
              ),
              SizedBox(height: 60,),

              InkWell(
                child: Column(
                  children: [
                    Widgets.gradienticon(FontAwesomeIcons.questionCircle, 50, LinearGradient(
                      colors: <Color>[
                        Colors.red,
                        Colors.brown,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    SizedBox(height: 5,),
                    Widgets.text('Ebrast', size: 23, color: Colors.brown, weight: FontWeight.w600)
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Ebrast()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}