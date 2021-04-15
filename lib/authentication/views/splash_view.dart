import 'package:dipro/constants.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(
                height: spaceXXL,
              ),
              SizedBox(
                height: spaceXXL,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
