import 'package:dipro/shared/widgets/gradient_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeLeading extends StatelessWidget {
  HomeLeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: GradientMask(
        child: Icon(
          FlutterIcons.navicon_faw,
        ),
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
