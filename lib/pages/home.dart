import 'package:flutter/material.dart';
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
            bottom: 80,
            top: 0,
            right: 10,
            child: Widgets.button('PATHOGENS', (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Pathogens()));
            }, size: 20 ),
          ),
 
          Positioned(
            bottom: 0,
            top: 80,
            left: 10,
            child: Widgets.button('MEDICINES', (){

            }, size: 20 ),
          ),
        ]),
      ),
    );
  }
}