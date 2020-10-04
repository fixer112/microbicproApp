import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:microbicpro/pages/auth/terms.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../../values.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var username = TextEditingController();
  var password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.times,
                              size: 15,
                            ),
                            onPressed: () {
                              Get.off(Login());
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Widgets.text('Create an account',
                            size: 20, weight: FontWeight.bold),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Widgets.textField(username, TextInputType.text, 'Username'),
                    Widgets.textField(
                        username, TextInputType.emailAddress, 'Email address'),
                    Widgets.textField(
                        username, TextInputType.phone, 'Phone number'),
                    Widgets.textField(
                        password, TextInputType.visiblePassword, 'Password'),
                    Widgets.textField(password, TextInputType.visiblePassword,
                        'Re-type Password'),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: !isLoading
                          ? Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      Future.delayed(Duration(seconds: 3))
                                          .then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        Widgets.snackbar(
                                            'Account created successfully');
                                      });
                                    },
                                    child: Widgets.text('Create',
                                        color: secondaryColor, size: 16),
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () => Get.to(Terms()),
                                    child: Widgets.text('Terms',
                                        color: primaryColor))
                              ],
                            )
                          : SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    primaryColor),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
