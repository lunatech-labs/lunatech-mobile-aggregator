import 'package:flutter/cupertino.dart';

class LunatechBackground extends StatelessWidget {
  final Widget child;

  const LunatechBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEA212E), Color(0xFF9B0F17)]
        )
      ),
      child: child,
    );
  }
}
