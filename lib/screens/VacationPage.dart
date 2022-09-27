import 'package:flutter/material.dart';

import '../widgets/LunatechDrawer.dart';

class VacationPage extends StatelessWidget {
  const VacationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vacation App")),
      drawer: LunatechDrawer(),
      body: const Text("Content")
    );
  }
}