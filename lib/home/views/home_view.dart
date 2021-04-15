import 'package:dipro/home/bloc/reports_bloc.dart';
import 'package:dipro/home/views/report_list_wrapper_view.dart';
import 'package:dipro/home/widgets/home_drawer.dart';
import 'package:dipro/home/widgets/home_floating_action_button.dart';
import 'package:dipro/home/widgets/home_leading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() { 
    super.initState();
    ReportsBloc reportsBloc = Get.find();
    reportsBloc.add(ReportsReloadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      drawerScrimColor: Colors.red.shade400.withOpacity(0.22),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: HomeLeading(),
        title: Text(
          'home.appbar.title.label'.tr,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ReportListWrapperView(),
      floatingActionButton: HomeFloatingActionButton(),
    );
  }
}
