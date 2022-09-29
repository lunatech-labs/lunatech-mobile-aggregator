import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LunatechLoading extends StatelessWidget {
  const LunatechLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: SpinKitRing(color: Colors.red));
  }
}