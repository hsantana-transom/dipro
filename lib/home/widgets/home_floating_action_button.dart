import 'package:dipro/screening/views/screening_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animations/animations.dart';

const double _fabDimension = 56.0;

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      useRootNavigator: true,
      closedColor: Colors.red.shade500,
      openColor: Colors.red.shade500,
      transitionDuration: Duration(milliseconds: 300),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_fabDimension / 2),
        ),
      ),
      transitionType: ContainerTransitionType.fade,
      openBuilder: (context, _) {
        return ScreeningView();
      },
      tappable: true,
      closedBuilder: (context, openContainer) {
        return SizedBox(
          height: _fabDimension,
          width: _fabDimension,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1,0.5],
                colors: [
                  Colors.red.shade300,
                  Colors.red.shade500,
                ],
              ),
            ),
            child: Center(
              child: Icon(FlutterIcons.plus_faw5s, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
