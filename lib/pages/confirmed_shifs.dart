import 'package:flutter/material.dart';
import '../models/shift.dart';
import 'dart:async';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import 'package:connectivity/connectivity.dart';


class ConfirmedShiftPage extends StatefulWidget {
  final MainModel model;

  ConfirmedShiftPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ConfirmedShift();
  }
}

class _ConfirmedShift extends State<ConfirmedShiftPage> {
  StreamSubscription<ConnectivityResult> _subscription;
  List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }


  ListTile makeListTile(Lesson lesson) =>
      ListTile(
        title: Container(
          child: Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.lens,
                      size: 16.0,
                      color: Color(0xFF8E8EBF),
                    ),
                    onPressed: () => {},
                  ),
                  Expanded(
//                      flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 1.0),
                        child: Text(lesson.title,
                            style: TextStyle(
                                color: Color(0xFF8E8EBF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.lens,
                      size: 16.0,
                      color: Color(0xFF8E8EBF),
                    ),
                    onPressed: () => {},
                  ),
                  Expanded(
//                      flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 1.0),
                        child: Text(lesson.title,
                            style: TextStyle(
                                color: Color(0xFF8E8EBF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Card makeCard(Lesson lesson) =>
      Card(
        elevation: 0.0,
        color: Color(0xFF242133),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(2.0),
              child: new Text(lesson.date,
//                    textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xFF7674A8), fontWeight: FontWeight.bold)),
            ),
            new Container(
              margin:
              new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Color(
                    0xFF37334D,
                  )),
              child: makeListTile(lesson),
            )
          ],
        ),
      );

  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color(0xFF242133),
    title: Text('Confirmed Shifts', style: TextStyle(fontSize: 24.0)),
  );

  @override
  Widget build(BuildContext context) {
    final makeBody = Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new TextField(
//    controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search date',
              prefixIcon: Icon(Icons.search, color: Color(0xFF7674A8)),
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: Color(0xFF7674A8),
                  ),
                  onPressed: () {}),
              hintStyle: TextStyle(color: Color(0xFF7674A8)),
              filled: true,
              fillColor: Color(0xFF37334D),
              contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
              enabledBorder: UnderlineInputBorder(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                borderSide: const BorderSide(color: Color(0xFF242133)),
              ),
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  borderSide: new BorderSide(color: Color(0xFF242133))),
            ),
          ),
        ),
        new Expanded(
          // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(lessons[index]);
            },
          ),
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        backgroundColor: Color(0xFF242133),
        appBar: topAppBar,
        body: makeBody,
      ),
    );
  }
}

List getLessons() {
  return [
    Lesson(
        date: "02/01/2019 08.45AM - 03.30PM",
        title: "Introduction to Driving",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 20,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        date: "03/01/2019 08.45AM - 03.30PM",
        title: "Observation at Junctions",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        date: "04/01/2019 08.45AM - 03.30PM",
        title: "Reverse parallel Parking",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        date: "05/01/2019 08.45AM - 03.30PM",
        title: "Reversing around the corner",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        date: "06/01/2019 08.45AM - 03.30PM",
        title: "Incorrect Use of Signal",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        date: "07/01/2019 08.45AM - 03.30PM",
        title: "Engine Challenges",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        date: "08/01/2019 08.45AM - 03.30PM",
        title: "Self Driving Car",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}

