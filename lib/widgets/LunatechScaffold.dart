import 'package:flutter/material.dart';

import 'LunatechDrawer.dart';

class LunatechScaffold extends StatefulWidget {
  const LunatechScaffold(
      {super.key, required this.body, this.appBar, this.floatingActionButton});

  final AppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  State<LunatechScaffold> createState() => _LunatechScaffoldState();
}

class _LunatechScaffoldState extends State<LunatechScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: isDrawerOpen() || isRoot(context) ? const LunatechDrawer() : null,
      floatingActionButton: widget.floatingActionButton,
      body: widget.body,
    );
  }

  bool isDrawerOpen() {
    return _scaffoldKey.currentState?.isDrawerOpen ?? false;
  }

  bool isRoot(BuildContext context) {
    return !(ModalRoute.of(context)?.canPop ?? false);
  }
}
