import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import '../models/shift.dart';
import '../models/location_data.dart';
import '../scoped_models/main.dart';
import 'package:map_view/map_view.dart';
import 'package:location/location.dart' as geoloc;
import 'package:http/http.dart' as http;
import '../shared/global_config.dart';

class ReleasedShiftPage extends StatefulWidget {
  final MainModel model;

  ReleasedShiftPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ReleaseShift();
  }
}

class _ReleaseShift extends State<ReleasedShiftPage> {
  List lessons;

  void _showMap() async {
    final location = geoloc.Location();
    final List<Marker> worklocation = <Marker>[];
    try {
      final currentLocation = await location.getLocation();
      print("lat");
      print(currentLocation.latitude);
      print("long");
      print(currentLocation.longitude);

//      worklocation.add(Marker('You', 'You', currentLocation.latitude, currentLocation.longitude,markerIcon:MarkerIcon('assets/Asset14@300x.png',height: 200.0,width: 200.0)));
//      worklocation.add(Marker('Client', 'Client', 6.7290, 79.9067,markerIcon:MarkerIcon('assets/Asset13@300x.png',height: 200.0,width: 200.0)));

    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not fetch Location'),
              content: Text(
                'Please add an address manually!',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

//  Widget _buildProductsList() {
//    _showMap();
//    return Align(
//      alignment: Alignment.bottomRight,
//      child: Container(
//        width: double.infinity,
//        margin: EdgeInsets.all(8.0),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(8.0),
//          color: Colors.white,
//        ),
//        child: Column(
//
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//                "Map is moving" ,
//                style: TextStyle(fontSize: 24.0),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//               "xxxx",
//                style: TextStyle(fontSize: 24.0),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _listTile(Lesson lesson) {
    return new ListTile(
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
                  onPressed: () {},
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
  }

  Widget _card(Lesson lesson) {
    return new Card(
      elevation: 0.0,
      color: Color(0xFF242133),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: new InkWell(
        onTap: () {
          _showMap();
//              if(){
//
//              }
          Navigator.pushReplacementNamed(context, '/map');
        },
        child: Column(
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
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Color(
                    0xFF37334D,
                  )),
              child: _listTile(lesson),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
//          return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF242133),
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xFF242133),
          title: Text('Released Shifts', style: TextStyle(fontSize: 24.0)),
        ),
        body: new Container(
          // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              return _card(lessons[index]);
            },
          ),
        ),
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
