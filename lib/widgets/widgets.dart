import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../values.dart';

class Widgets {
  static button(String text, Function callback,
      {Color color, Color tcolor = Colors.black, double size = 15.0}) {
    return FlatButton(
      onPressed: callback,
      color: color,
      child: Widgets.text(text, size: size, color: tcolor),
      //splashColor: primaryColor,
    );
  }

  static text(
    String text, {
    Color color,
    double size,
    FontWeight weight,
    TextAlign align,
    String family,
    FontStyle style,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontFamily: family,
        fontStyle: style,
      ),
      textAlign: align,
    );
  }

  static collapsible(String title, List<Widget> widgets) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ExpandablePanel(
          header: Container(
            padding: EdgeInsets.only(top: 8),
            child: Widgets.text(title, size: 17, weight: FontWeight.w600),
          ),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ),
      ),
    );
  }

  static ExpansionPanel expansion(title, List<Widget> widgets,
      {bool isExpanded = false}) {
    return ExpansionPanel(
      isExpanded: isExpanded,
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) {
        //print(isExpanded);
        return ListTile(
          title: Widgets.text(title, size: 17, weight: FontWeight.w600),
        );
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  static header(String title) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      child: Widgets.text(title, size: 20),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        //border: Border(bottom: BorderSide(color: primaryColor)),
        color: Color(0xffd7d7d7),
      ),
    );
  }

  static container(String placeholder) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(35),
        alignment: Alignment.center,
        child: Widgets.text(placeholder,
            size: 20,
            color: Colors.white,
            weight: FontWeight.bold,
            align: TextAlign.center),
        height: 125,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  static gradienticon(IconData icon, double size, Gradient gradient) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }

  static centerText(String text, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      child: Center(
        child: Widgets.text(text, size: 20.0),
      ),
    );
  }

  static Widget loader() {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static snackbar(message, {title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      borderRadius: 5,
    );
  }
}
