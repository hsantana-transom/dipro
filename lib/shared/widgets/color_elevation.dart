import 'package:flutter/material.dart';

class ColorElevation extends StatelessWidget {
  final Widget child;
  final Color color;

  ColorElevation({@required this.child, this.color}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (this.color ?? Colors.red.shade400).withOpacity(0.5),
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: this.child,
    );
  }
}