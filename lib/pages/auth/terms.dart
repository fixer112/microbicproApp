import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/auth/register.dart';
import 'package:microbicpro/widgets/widgets.dart';

import 'login.dart';

class Terms extends StatefulWidget {
  Terms({Key? key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
            child: Widgets.text(
              """The entire content for this application have been extensively reviewed.
                \nHowever, the publisher and developer or any employee of MicrobicPro's world are not responsible for any omissions or errors nor any legal compensation or other repercussions from use of this information. 
                \nThis information is intended as a guide, and cannot replace the professional judgement of a licensed physician, pharmacist or other healthcare professionals. 
                \nThe content is reviewed and updated on a regular basis but MicrobicPro's world makes no guarantees, representations or warranties regarding the accuracy, complete ness or currency of the information within the software. 
                \nMicrobicPro's world expressly disclaims responsibility and shall have no liability for any damages, loss or liability whatsoever suffered as a result of your reliance on the information contained in this application. 
                \nMicrobicPro's world also does not endorse specifically any information contained in this application.""",
              size: 18,
            ),
          ),
        ),
        Widgets.button('I Agree', () async {
          Get.off(() => Register());
        }),
        Widgets.button('I Disagree', () async {
          Get.off(() => Login());
        }),
      ]),
    );
  }
}
