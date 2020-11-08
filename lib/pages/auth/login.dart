import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/api_functions.dart';
import 'package:microbicpro/functions.dart';
import 'package:microbicpro/model/user.dart';
import 'package:microbicpro/pages/auth/register.dart';
import 'package:microbicpro/pages/home.dart';
import 'package:microbicpro/provider/main.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //var main = Provider.of<MainModel>(context, listen: false);

    loadUser();
  }

  loadUser() async {
    setState(() {
      loading = true;
    });

    var main = Provider.of<MainModel>(context, listen: false);

    try {
      var data = await getJson(fileName: 'users.json');
      //print(data);
      if (data != null) {
        data = jsonDecode(data);
        User user = User.fromMap(data);
        main.setUser(user);
        if (main.getUser != null) Get.off(Home());
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /* getJson().then((value) {
      if (value != null) {
        print(jsonDecode(value));
        login(jsonDecode(value), context);
      }
    }); */
    return Scaffold(
      body: Center(
        child: loading
            ? Widgets.loader()
            : ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    margin: EdgeInsets.all(20),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            child: Image.asset('assets/img/logo.png'),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Widgets.textFormField('email', email,
                                    validate: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "username can't be empty";
                                  }
                                }),
                                Widgets.textFormField('password', password,
                                    type: TextInputType.visiblePassword,
                                    validate: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "password can't be empty";
                                  }
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: !isLoading
                                ? Container(
                                    width: 150,
                                    child: FlatButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (_formKey.currentState.validate()) {
                                          var data = {
                                            'email': email.text,
                                            'password': password.text,
                                          };
                                          await login(data, context);
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                      child: Widgets.text('Login',
                                          color: secondaryColor, size: 16),
                                      color: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              primaryColor),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Widgets.text('Don\'t have an account? '),
                              InkWell(
                                child: Widgets.text('Sign up',
                                    color: primaryColor),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Register(),
                                      ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Widgets.text('Forgot Password? '),
                              InkWell(
                                child: Widgets.text('Change Password',
                                    color: primaryColor),
                                onTap: () async {
                                  var link = "$url/password/reset";
                                  if (await canLaunch(link)) {
                                    await launch(link);
                                  } else {
                                    Widgets.snackbar('Error loading link');
                                  }
                                },
                              ),
                            ],
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
