import 'package:flutter/material.dart';

class ScreeningResultError extends StatelessWidget {
  const ScreeningResultError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(child: Text('Ocurrio un error')),
        ],
      ),
    );
  }
}
