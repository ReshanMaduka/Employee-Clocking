import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './profile.dart';
import '../models/shift.dart';
import '../scoped_models/main.dart';

class ShiftHomePage extends StatefulWidget {
  final MainModel model;

  ShiftHomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ShiftHomePage();
  }
}

class _ShiftHomePage extends State<ShiftHomePage> {
  List lessons;
  PageController controller = PageController();
  var currentPageValue = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
    lessons = getLessons();
    super.initState();
  }

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

  Widget _availabilityTile(Lesson lesson) {
    return new ListTile(
      title: Container(
        child: Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    width: 35.0,
                    height: 35.0,
                    child: FloatingActionButton(
                        onPressed: null,
                        backgroundColor: Colors.green,
                        child: Text("AM"),
                    )
                ),
                Container(
                    width: 35.0,
                    height: 35.0,
                    child: FloatingActionButton(
                        onPressed: null,
                        backgroundColor: Colors.green,
                        child: Text("PM"))
                ),
                Container(
                    width: 35.0,
                    height: 35.0,
                  child: FloatingActionButton(
                      onPressed: null,
                      backgroundColor: Colors.green,
                      child: Text("NS"))
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
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: new InkWell(
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

  Widget _avilabiltiyCard(Lesson lesson) {
    return new Card(
      elevation: 0.0,
      color: Color(0xFF242133),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: new InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(2.0),
              child: new Text("Availability",
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color(
                    0xFF3A8DFD,
                  )),
              child: _availabilityTile(lesson),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String line1 = "Hey Fernando";
    String line2 = "this is your Roster.";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF242133),
        appBar: AppBar(
          title: Text(
            line1 + "\n" + line2,
            style: TextStyle(fontSize: 24.0),
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xFF242133),
        ),
        body: new Container(
          child: PageView.builder(
//            physics: new AlwaysScrollableScrollPhysics(),
            controller: controller,
            itemBuilder: (context, position) {
              if (position == currentPageValue.floor()) {
                print("0");
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.004)
                    ..rotateY(currentPageValue - position)
                    ..rotateZ(currentPageValue - position),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        color: const Color(0xFF242133),
                        child: new Padding(
                          padding: new EdgeInsets.all(15.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(text: "Today"),
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                            autofocus: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
//                             _mainBottomSheet(context);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.arrow_left,
                                  color: Color(0xFF7674A8)),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    color: Color(0xFF7674A8),
                                  ),
                                  onPressed: () {
//                                   _txtSearch.clear();
//                                   resetSchedule();
                                  }),
                              hintStyle: TextStyle(color: Color(0xFF7674A8)),
                              filled: true,
                              fillColor: const Color(0xFF242133),
//                               contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(10.0)),
                                borderSide:
                                const BorderSide(color: Color(0xFF242133)),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  borderSide:
                                  new BorderSide(color: Color(0xFF242133))),
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return _avilabiltiyCard(lessons[index]);
                          },
                        ),
                      ),
                      new Container(
                        color: const Color(0xFF242133),
                        child: new Padding(
                          padding: new EdgeInsets.all(0.0),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller:
                            TextEditingController(text: "Confirmed Shifts"),
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                            autofocus: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
//                             _mainBottomSheet(context);
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Color(0xFF7674A8)),
                              filled: true,
                              fillColor: const Color(0xFF242133),
//                               contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(10.0)),
                                borderSide:
                                const BorderSide(color: Color(0xFF242133)),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  borderSide:
                                  new BorderSide(color: Color(0xFF242133))),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return _card(lessons[index]);
                              },
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                );
              } else if (position == currentPageValue.floor() + 1) {
                print("1");
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.004)
                    ..rotateY(currentPageValue - position)
                    ..rotateZ(currentPageValue - position),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        color: const Color(0xFF242133),
                        child: new Padding(
                          padding: new EdgeInsets.all(15.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(text: "2019"),
                            style: TextStyle(color: Colors.white),
                            autofocus: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
//                             _mainBottomSheet(context);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.arrow_left,
                                  color: Color(0xFF7674A8)),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    color: Color(0xFF7674A8),
                                  ),
                                  onPressed: () {
//                                   _txtSearch.clear();
//                                   resetSchedule();
                                  }),
                              hintStyle: TextStyle(color: Color(0xFF7674A8)),
                              filled: true,
                              fillColor: const Color(0xFF242133),
                              contentPadding:
                              EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(10.0)),
                                borderSide:
                                const BorderSide(color: Color(0xFF242133)),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  borderSide:
                                  new BorderSide(color: Color(0xFF242133))),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                print("2");
                return Container(
                  color: position % 2 == 0 ? Colors.blue : Colors.pink,
                  child: Column(
                    children: <Widget>[
                      new Container(
                        color: const Color(0xFF242133),
                        child: new Padding(
                          padding: new EdgeInsets.all(15.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(text: "2019"),
                            style: TextStyle(color: Colors.white),
                            autofocus: false,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
//                             _mainBottomSheet(context);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.arrow_left,
                                  color: Color(0xFF7674A8)),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    color: Color(0xFF7674A8),
                                  ),
                                  onPressed: () {
//                                   _txtSearch.clear();
//                                   resetSchedule();
                                  }),
                              hintStyle: TextStyle(color: Color(0xFF7674A8)),
                              filled: true,
                              fillColor: const Color(0xFF242133),
                              contentPadding:
                              EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(10.0)),
                                borderSide:
                                const BorderSide(color: Color(0xFF242133)),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  borderSide:
                                  new BorderSide(color: Color(0xFF242133))),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          itemCount: 5,
          ),
        )

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
