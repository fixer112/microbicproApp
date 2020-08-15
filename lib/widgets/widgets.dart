import 'package:flutter/material.dart';
import '../values.dart';

class Widgets {

  static button( String text, Function callback, { Color color, Color tcolor=Colors.black, double size=15.0 } ){
    return FlatButton(
      onPressed: callback,
      color: color,
      child: Widgets.text(text, size: size, color: tcolor),
      //splashColor: primaryColor,
    );
  }

  static text( String text, { Color color, double size, FontWeight weight, TextAlign align, String family } ){
    return Text( text, style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
      fontFamily: family,
      ),
      textAlign: align,
    );
  }

}