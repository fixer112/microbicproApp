import 'package:flutter/material.dart';
import 'package:microbicpro/values.dart';
import 'package:microbicpro/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon( Icons.arrow_back, color: primaryColor, ), onPressed: (){
          Navigator.pop(context);
        }),

        title: Container(
          height: 40,
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Search...',
              border: UnderlineInputBorder(),
              /*suffixIcon: IconButton(
                icon: Icon( Icons.cancel, color: primaryColor, ),
                splashColor: Colors.transparent,
                onPressed: (){
                  _searchController.clear();
                }
              ),*/
            ),
          ),
        ),
      ),
      body: Center(
        child: Widgets.text('Search Page'),
      ),
    );
  }
}