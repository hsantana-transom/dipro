import 'package:flutter/material.dart';

class GradientMask extends StatelessWidget {
  const GradientMask({
    Key key,
    this.child,
    this.blendMode = BlendMode.modulate,
    this.startColor,
    this.endColor,
  }) : super(key: key);

  final Widget child;
  final BlendMode blendMode;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: blendMode,
        shaderCallback: (rect) {
          return LinearGradient(
            end: Alignment.bottomCenter,
            colors: [
              this.startColor ?? Colors.red.shade400,
              this.endColor ?? Colors.red.shade500,
            ],
          ).createShader(rect);
        },
        child: child);
  }
}
