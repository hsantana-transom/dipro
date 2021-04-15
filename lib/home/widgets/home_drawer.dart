import 'package:dipro/authentication/bloc/authentication_bloc.dart';
import 'package:dipro/shared/widgets/gradient_mask.dart';
import 'package:flutter/material.dart';
import 'package:dipro/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GradientMask(
        blendMode: BlendMode.screen,
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.symmetric(vertical: paddingXL),
                child: Image.asset(
                  'assets/images/logo.png',
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Get.toNamed('/settings');
                },
                leading: Icon(FlutterIcons.settings_fea, color: Colors.white),
                title: Text(
                  'home.drawer.items.settings.label'.tr,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.defaultDialog(
                      title: 'home.dialog.title.label'.tr,
                      content: Text('home.drawer.items.logout.label'.tr),
                      textCancel: 'home.dialog.cancel-button.label'.tr,
                      textConfirm: 'home.dialog.confirm-button.label'.tr,
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequest());
                        Navigator.pop(context);
                      });
                },
                leading: Icon(FlutterIcons.sign_out_faw, color: Colors.white),
                title: Text(
                  'home.drawer.items.logout.label'.tr,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
