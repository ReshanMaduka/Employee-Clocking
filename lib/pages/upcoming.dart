import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './profile.dart';
//import '../widgets/products/products.dart';
//import '../widgets/ui_elements/logout_list_tile.dart';
import '../scoped_models/main.dart';

class UpcommingPage extends StatefulWidget {

  final MainModel model;
  UpcommingPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SchedulesPageState();
  }
}

class _SchedulesPageState extends State<UpcommingPage> {
  @override
  initState() {
//    widget.model.fetchUserSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xFF242133),

    );
  }
}
