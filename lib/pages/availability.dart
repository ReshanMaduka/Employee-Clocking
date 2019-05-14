import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class AvailabilityPage extends StatelessWidget {
  final MainModel model;

  AvailabilityPage(this.model);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF242133),
        appBar: AppBar(
          title: Text("Availability",style: TextStyle(fontSize: 24.0)),
          elevation: 0.0,
          backgroundColor: const Color(0xFF242133),
        ),
        body: new Column(),
      ),
    );
  }
}
