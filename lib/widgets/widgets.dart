import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../values.dart';

class Widgets {
  static button(String text, Function callback,
      {Color color, Color tcolor = Colors.white, double size = 15.0}) {
    return FlatButton(
      onPressed: callback,
      color: color == null ? primaryColor : color,

      child: Widgets.text(text, size: size, color: tcolor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      //splashColor: primaryColor,
    );
  }

  static Text text(
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

  static Widget iconImage(icon, {double width = 40, double height = 40}) {
    return Image.asset(
      'assets/icons/$icon',
      width: width,
      height: height,
    );
  }

  static Widget collapsible(String title, List<Widget> widgets,
      {String icon, double width = 45, double height = 45}) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ExpandableNotifier(
          child: ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              header: Container(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    /* if (icon != null)
                      iconImage(icon, width: width, height: height), */
                    Widgets.text(title, size: 17, weight: FontWeight.w600),
                  ],
                ),
              ),
              expanded: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgets,
                  ),
                ],
              ),
            ),
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

  static Widget header(String title,
      {String icon, double width = 20, double height = 20}) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          //if (icon != null) iconImage(icon, width: width, height: height),
          Widgets.text(title, size: 20),
        ],
      ),
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

  static textField(
      TextEditingController controller, TextInputType type, String hintText,
      {suffixWidget}) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 10.0),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: suffixWidget,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              hintText: hintText,
              contentPadding: EdgeInsets.all(10).copyWith(left: 30),
              hintStyle: TextStyle(color: Colors.black)),
          obscureText: type == TextInputType.visiblePassword ? true : false,
          keyboardType: type),
    );
  }

  static textFormField(String hint, TextEditingController controller,
      {validate(String text), type = TextInputType.text}) {
    return Container(
      //height: 50.0,
      margin: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        keyboardType: type,
        obscureText: type == TextInputType.visiblePassword ? true : false,
        controller: controller,
        decoration: InputDecoration(
          //suffixIcon: suffixWidget,
          fillColor: Colors.white,
          filled: true,
          //errorBorder: OutlineInputBorder(),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          hintText: hint,
          contentPadding: EdgeInsets.all(10).copyWith(left: 30),
          hintStyle: TextStyle(color: Colors.black),
        ),
        //textAlign: TextAlign.center,
        validator: validate,
      ),
    );
  }

  static Widget dropdown(
      hint, value, List<DropdownMenuItem> items, action(val)) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: value,
          items: items,
          hint: Widgets.text(hint, weight: FontWeight.bold),
          icon: Icon(
            FontAwesomeIcons.chevronDown,
            size: 20,
          ),
          underline: Container(),
          isExpanded: true,
          onChanged: action,
        ),
      ),
    );
  }

  static Widget dropdownForm(hint, value, List<DropdownMenuItem> items,
      {action(val), validate(val)}) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          //suffixIcon: suffixWidget,
          fillColor: Colors.white,
          filled: true,
          //errorBorder: OutlineInputBorder(),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          hintText: hint,
          contentPadding: EdgeInsets.all(10).copyWith(left: 30),
          hintStyle: TextStyle(color: Colors.black),
        ),
        value: value,
        items: items,
        hint: Widgets.text(hint, weight: FontWeight.bold),
        icon: Icon(
          FontAwesomeIcons.chevronDown,
          size: 20,
        ),
        isExpanded: true,
        onChanged: action,
        validator: validate,
      ),
    );
  }
}
