import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:microbicpro/pages/auth/profile.dart';
import 'package:microbicpro/pages/ebrast/ebrast.dart';
import 'package:microbicpro/pages/guidelines/guidelines.dart';
import 'package:microbicpro/pages/medicines/medicines.dart';
import 'package:microbicpro/pages/pathogens/pathogens.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../values.dart';

class Pager extends StatefulWidget {
  const Pager(
    this.title,
    this.widgets, {
    super.key,
    this.search = false,
    this.willPop = true,
    this.refresh,
    this.bottomBarIndex = 0,
    this.onSearch,
  }) : assert(
          !search || onSearch != null,
          'Provide an onSearch callback when search is enabled.',
        );

  final String title;
  final List<Widget> widgets;
  final bool search;
  final bool willPop;
  final Future<void> Function()? refresh;
  final int bottomBarIndex;
  final ValueChanged<String>? onSearch;

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    if (widget.onSearch != null) {
      _controller.addListener(() => widget.onSearch!(_controller.text));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    if (widget.refresh != null) {
      await widget.refresh!();
    }
    // Give the indicator a moment to settle even if no refresh was provided.
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        labelText: 'Search',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  void _navigate(int index) {
    final destinations = <Widget Function()>[
      () => Guidelines(),
      () => Pathogens(),
      () => Medicines(),
      () => Ebrast(),
      () => Profile(),
    ];
    if (index >= 0 && index < destinations.length) {
      Get.to(destinations[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.willPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: _isSearching ? _buildSearchField() : Text(widget.title),
          actions: [
            if (widget.search)
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) {
                      _controller.clear();
                    }
                  });
                },
              ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: widget.widgets,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.bottomBarIndex,
          backgroundColor: Colors.white,
          onTap: _navigate,
          items: [
            BottomNavigationBarItem(
              icon: Widgets.gradienticon(
                FontAwesomeIcons.squareCheck,
                20,
                const LinearGradient(
                  colors: [Colors.orange, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              label: 'Guidelines',
            ),
            BottomNavigationBarItem(
              icon: Widgets.gradienticon(
                FontAwesomeIcons.disease,
                20,
                const LinearGradient(
                  colors: [Colors.green, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              label: 'Pathogens',
            ),
            BottomNavigationBarItem(
              icon: Widgets.gradienticon(
                FontAwesomeIcons.bookMedical,
                20,
                const LinearGradient(
                  colors: [Colors.indigo, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              label: 'Medicines',
            ),
            BottomNavigationBarItem(
              icon: Widgets.gradienticon(
                FontAwesomeIcons.circleQuestion,
                20,
                const LinearGradient(
                  colors: [Colors.red, Colors.brown],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              label: 'Ebrast',
            ),
            BottomNavigationBarItem(
              icon: Widgets.gradienticon(
                FontAwesomeIcons.user,
                20,
                const LinearGradient(
                  colors: [Colors.red, Colors.brown],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
