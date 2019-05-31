import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './profile.dart';

import '../scoped_models/main.dart';
import './upcoming.dart';
import './notification.dart';

class SchedulesPage extends StatelessWidget {


  final MainModel model;
  SchedulesPage(this.model);

  @override
  Widget build(BuildContext context) {
    String line1 = "Hey Pathum";
    String line2 = "this is your Roster.";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color(0xFF242133),
          appBar: AppBar(
            title: Text(line1+"\n"+line2,style: TextStyle(fontSize: 24.0),),
            elevation: 0.0,
            backgroundColor: const Color(0xFF242133),
          ),
          body: new Column(),
        ),
    );
  }
}
