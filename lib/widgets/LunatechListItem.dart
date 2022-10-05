import 'package:flutter/material.dart';

class LunatechListItem extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  final double width;

  const LunatechListItem({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.height = 120,
    this.width = 280
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 5
                  //blurRadius:
                  )
            ]),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: color,
            child: child
        ),
      ),
    );
  }
}
