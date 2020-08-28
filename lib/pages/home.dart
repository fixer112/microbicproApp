import 'package:flutter/material.dart';
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
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              child: Image.asset('assets/img/bg-home.png'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(left: 0,right: 0,top: 0,bottom: 0, child: Container(color: Colors.black.withOpacity(0),),),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Widgets.button('GUIDELINES', (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => Guidelines()));
            }, size: 20, tcolor: primaryColor ),
          ),
 
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Widgets.button('EBRAST', (){

            }, size: 20, tcolor: primaryColor ),
          ),
 
          Positioned(
            bottom: center+25,
            right: 10,
            child: Widgets.button('PATHOGENS', (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Pathogens()));
            }, size: 20 ),
          ),
 
          Positioned(
            top: center+25,
            left: 10,
            child: Widgets.button('MEDICINES', (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Medicines()));
            }, size: 20 ),
          ),
        ]),
      ),
    );
  }
}