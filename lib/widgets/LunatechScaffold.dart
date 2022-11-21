import 'package:flutter/material.dart';

import 'LunatechDrawer.dart';

class LunatechScaffold extends StatelessWidget {
  LunatechScaffold(
      {super.key, required this.body, this.appBar, this.floatingActionButton});

  final AppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: isDrawerOpen() || isRoot(context) ? const LunatechDrawer() : null,
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }

  bool isDrawerOpen() {
    return _scaffoldKey.currentState?.isDrawerOpen ?? false;
  }

  bool isRoot(BuildContext context) {
    return !(ModalRoute.of(context)?.canPop ?? false);
  }
}
