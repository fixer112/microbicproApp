import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:microbicpro/pages/auth/terms.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../../values.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var email = TextEditingController();
  var location;
  var profession;
  var areaOfPractice;
  var yearsOfPractice;
  var locations = [
    'lagos',
    'abuja',
    'abeokuta',
    'ife',
    'osogbo',
    'ilesha',
    'benin',
    'portharcourt',
    'kano',
    'kaduna',
    'enugu',
    'anambra',
    'ilorin',
    'jos'
  ];
  List<String> professions = [
    'physician',
    'medical consultant',
    'surgeon',
    'consultant surgeon',
    'pharmacist',
    'dentist',
    'nurse',
    'matron',
    'physiotherapist',
    'medical laboratory scientist',
    'medical laboratory technician',
    'pathologist',
    'medical sales representative',
    'medical student',
    'pharmacy student',
    'others',
  ];
  var areaOfPractices = [
    'tertiary hospital',
    'state hospital',
    'private hospital',
    'primary health center',
    'community pharmacy',
    'laboratory',
    'others',
  ];
  var yearsOfPractices = [
    'less than 1 year',
    'between 1-3 years',
    '4-6 years',
    '7-10 years',
    '10-15 years',
    'abve 15 years',
  ];
  List<DropdownMenuItem<String>> professionList = [];
  List<DropdownMenuItem<String>> areaList = [];
  List<DropdownMenuItem<String>> yearList = [];
  List<DropdownMenuItem<String>> locationList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLoading = false;
    locationList = locations
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.toUpperCase()),
            value: e,
          ),
        )
        .toList();
    professionList = professions
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.toUpperCase()),
            value: e,
          ),
        )
        .toList();

    areaList = areaOfPractices
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.toUpperCase()),
            value: e,
          ),
        )
        .toList();
    yearList = yearsOfPractices
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.toUpperCase()),
            value: e,
          ),
        )
        .toList();
    //print(professionList);
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
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        Widgets.textFormField('First Name', firstName,
                            validate: (text) {
                          if (text == null || text.isEmpty) {
                            return "field required";
                          }
                        }),
                        Widgets.textFormField('Last Name', lastName,
                            validate: (text) {
                          if (text == null || text.isEmpty) {
                            return "field required";
                          }
                        }),
                        Widgets.textFormField('Email', email, validate: (text) {
                          if (text == null || text.isEmpty) {
                            return "field required";
                          }
                        }, type: TextInputType.emailAddress),
                        Widgets.dropdownForm(
                          'Select Profession',
                          profession,
                          professionList,
                          action: (val) => setState(() {
                            profession = val;
                          }),
                          validate: (val) {
                            if (val == null || val.isEmpty) {
                              return "field required";
                            }
                          },
                        ),
                        Widgets.dropdownForm(
                          'Select Area of Practice',
                          areaOfPractice,
                          areaList,
                          action: (val) => setState(() {
                            areaOfPractice = val;
                          }),
                          validate: (val) {
                            if (val == null || val.isEmpty) {
                              return "field required";
                            }
                          },
                        ),
                        Widgets.dropdownForm(
                          'Select Years of Practice',
                          yearsOfPractice,
                          yearList,
                          action: (val) => setState(() {
                            yearsOfPractice = val;
                          }),
                          validate: (val) {
                            if (val == null || val.isEmpty) {
                              return "field required";
                            }
                          },
                        ),
                        Widgets.dropdownForm(
                          'Select Location',
                          location,
                          locationList,
                          action: (val) => setState(() {
                            location = val;
                          }),
                          validate: (val) {
                            if (val == null || val.isEmpty) {
                              return "field required";
                            }
                          },
                        ),
                        Widgets.textFormField('Password', password,
                            validate: (text) {
                          if (text == null || text.isEmpty) {
                            return "field required";
                          }
                        }, type: TextInputType.visiblePassword),
                        Widgets.textFormField(
                            'Confirm Password', confirmPassword,
                            validate: (text) {
                          if (text == null || text.isEmpty) {
                            return "field required";
                          }
                        }, type: TextInputType.visiblePassword),
                      ]),
                    ),
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
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (_formKey.currentState.validate()) {
                                        var data = {
                                          'first_name': firstName.text,
                                          'last_name': lastName.text,
                                          'email': email.text,
                                          'password': password.text,
                                          'password_confirmation':
                                              confirmPassword.text,
                                          'profession': profession,
                                          'area_of_practice': areaOfPractice,
                                          'location': location,
                                          'years_of_practice': yearsOfPractice,
                                        };

                                        await register(data, context);
                                      }
                                      setState(() {
                                        isLoading = false;
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
