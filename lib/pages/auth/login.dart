import 'package:flutter/material.dart';
import 'package:microbicpro/pages/auth/register.dart';
import 'package:microbicpro/pages/home.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var username = TextEditingController();
  var password = TextEditingController();

  bool isLoading  = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              margin: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Container(
                      width: 250,
                      child: Image.asset('assets/img/logo.jpeg'),
                    ),
                    SizedBox(height: 30,),

                    Widgets.textField(username, TextInputType.text, 'Username'),
                    Widgets.textField(password, TextInputType.visiblePassword, 'Password'),
                    
                    SizedBox(height: 30,),
                    Center(
                      child: !isLoading ? Container(
                        width: 150,
                        child: FlatButton(
                          onPressed: (){
                            setState(() {
                              isLoading = true;
                            });

                            Future.delayed(Duration(seconds: 3)).then((value) {  
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Home(),
                              ));
                              setState(() {
                                isLoading = false;
                              });
                            });
                          },
                          child: Widgets.text('Login', color: secondaryColor, size: 16),
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ) : SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets.text('Don\'t have an account? '),
                        InkWell(
                          child: Widgets.text('Sign up', color: primaryColor),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Register(),
                            ));
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