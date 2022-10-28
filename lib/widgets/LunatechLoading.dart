import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LunatechLoading extends StatelessWidget {
  const LunatechLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Center(child: SpinKitRing(color: Theme.of(context).colorScheme.background)));
  }

  stopLoading(BuildContext context){
    Navigator.pop(context);
  }
}
