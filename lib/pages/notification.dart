import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './profile.dart';
//import '../widgets/products/products.dart';
//import '../widgets/ui_elements/logout_list_tile.dart';
import '../scoped_models/main.dart';

class NotificationPage extends StatefulWidget {
  final MainModel model;
  NotificationPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  initState() {
//    widget.model.fetchUserSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: const Color(0xFF242133),
      appBar: AppBar(
        title: Text('Notification'),
        elevation: 0.0,
        backgroundColor: const Color(0xFF242133),
      ),
    );
  }
}
