import 'package:flutter/material.dart';
import '../models/shift.dart';
import 'package:date_format/date_format.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Shifts.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/ui_elements/bottom_model.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';

class ConfirmedShiftPage extends StatefulWidget {
  final MainModel model;

  ConfirmedShiftPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ConfirmedShift();
  }
}

class _ConfirmedShift extends State<ConfirmedShiftPage> with TickerProviderStateMixin {
  Modal popupModal = new Modal();
  final formats = {
    InputType.date: DateFormat("EEEE, M d, yyyy"),
    InputType.time: DateFormat("HH:mm"),
  };

  static final now = new DateTime.now();
  static final formatter = new DateFormat('yyyy-MM-dd');
  static final currentDate = formatter.format(now);

  static final endDate = now.add(new Duration(days: 5));
  static final format = new DateFormat('yyyy-MM-dd');
  static final toDate = format.format(endDate);

  TextEditingController _startDate = new TextEditingController();
  TextEditingController _endDate = new TextEditingController();
  TextEditingController _txtSearch = new TextEditingController();

  InputType inputType = InputType.date;
  bool editable = false;
  DateTime date;
  bool _isLoading = true;

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  StreamSubscription<ConnectivityResult> _subscription;
  TextEditingController controller = new TextEditingController();
  final List<Shift> _searchResult = [];
  List<Shift> _shiftDetails = [];
  List<Shift> _filterResult = [];
  String conState;

  void _showSnackBar() {
    _scaffoldstate.currentState.showSnackBar(new SnackBar(
      content: new Text('No Connection', textAlign: TextAlign.center),
      backgroundColor: Color(0xFFE74C3C),
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    ));
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(0.5, -1.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );
    super.initState();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.toString() == "ConnectivityResult.none") {
        conState = result.toString();
        print(conState);
        _showSnackBar();
      } else {
        conState = result.toString();
        print(conState);
      }
      widget.model
          .fetchUser(new http.Client(), currentDate, toDate)
          .then((String) {
        parseData(String);
        _isLoading = false;
      });
    });
  }

  List<Shift> allRecord;

  parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    setState(() {
      allRecord =
          parsed.map<Shift>((json) => new Shift.fromJson(json)).toList();
    });
    _shiftDetails = new List<Shift>();
    _shiftDetails.addAll(allRecord);
    print(_shiftDetails.length);
    print(_shiftDetails);
    _isLoading = false;
    print(_isLoading);
  }

  @override
  dispose() {
    super.dispose();
    _subscription.cancel();
    print("dispose");
  }

  Widget _mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.transparent,
            child: new ResponsiveContainer(
              heightPercent: MediaQuery.of(context).size.height,
              widthPercent: MediaQuery.of(context).size.width,
              child: new Container(
                child: new Column(
//                  mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(top: 20.0, left: 10.0),
                      child: new ListTile(
                        title: new Text(
                          'Select Date',
                          style: TextStyle(
                              color: Color(0xFF2F3542),
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0),
                        ),
                      ),
                    ),
                    new Container(
                      padding:
                          EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              DateTimePickerFormField(
                                controller: _startDate,
                                inputType: inputType,
                                format: formats[inputType],
                                editable: editable,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    labelText: 'Start Date',
                                    labelStyle:
                                        TextStyle(color: Colors.black26),
                                    hasFloatingPlaceholder: false),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                child: new Icon(Icons.more_vert,
                                    color: Colors.black),
                                padding: EdgeInsets.only(right: 450.0),
                              ),
                              SizedBox(height: 15.0),
                              DateTimePickerFormField(
                                controller: _endDate,
                                inputType: inputType,
                                format: formats[inputType],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    labelText: 'End Date',
                                    labelStyle:
                                        TextStyle(color: Colors.black26),
                                    hasFloatingPlaceholder: false),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Expanded(
                      child: new Container(),
                    ),
                    new Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: new RaisedButton(
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                color: Color(0xFF3DC149),
                                elevation: 0.0,
                                splashColor: Colors.blueGrey,
                                onPressed: () {
                                  setState(() {
                                    _txtSearch.text = _startDate.text +"-"+ _endDate.text;
                                  });
                                  onSearchTextChanged(
                                      _startDate.text, _endDate.text);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      topRight: const Radius.circular(50.0)),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    new MaterialApp();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        key: _scaffoldstate,
        backgroundColor: Color(0xFF242133),
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xFF242133),
          title: Text('Confirmed Shifts', style: TextStyle(fontSize: 24.0)),
        ),
        body: new Column(
          children: <Widget>[
            new Container(
              color: Color(0xFF242133),
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: new TextField(
                  controller: _txtSearch,
                  style: TextStyle(color: Colors.white),
                  autofocus: false,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _mainBottomSheet(context);
                  },
//                focusNode: ,
                  decoration: InputDecoration(
                    hintText: 'Search date',
                    prefixIcon: Icon(Icons.search, color: Color(0xFF7674A8)),
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Color(0xFF7674A8),
                        ),
                        onPressed: () {
                          _txtSearch.clear();
                          resetSchedule();
                        }),
                    hintStyle: TextStyle(color: Color(0xFF7674A8)),
                    filled: true,
                    fillColor: Color(0xFF37334D),
                    contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 15.0),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0)),
                      borderSide: const BorderSide(color: Color(0xFF242133)),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(10.0)),
                        borderSide: new BorderSide(color: Color(0xFF242133))),
                  ),
                ),
              ),
            ),
            new Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _searchList()
                    : _buildReleasedShift()),
          ],
        ),
      ),
    );
  }

  Widget _shift() {
    return ListView.builder(
      itemCount: _shiftDetails.length,
      itemBuilder: (context, index) {
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
                  child: new Text(
                      _shiftDetails[index].shiftDate +
                          "  " +
                          _shiftDetails[index].shiftStart +
                          " - " +
                          _shiftDetails[index].shiftEnd,
//                    textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF7674A8),
                          fontWeight: FontWeight.bold)),
                ),
                new Container(
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Color(
                        0xFF37334D,
                      )),
                  child: new ListTile(
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
                                    child: Text(_shiftDetails[index].address,
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
                                    child: Text(
                                        _shiftDetails[index].candidateId,
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchList() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
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
                  child: new Text(
                      _searchResult[index].shiftDate +
                          "  " +
                          _searchResult[index].shiftStart +
                          " - " +
                          _searchResult[index].shiftEnd,
//                    textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF7674A8),
                          fontWeight: FontWeight.bold)),
                ),
                new Container(
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Color(
                        0xFF37334D,
                      )),
                  child: new ListTile(
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
                                    child: Text(_searchResult[index].address,
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
                                    child: Text(
                                        _searchResult[index].candidateId,
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
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReleasedShift() {
    print("xyz");

    print(_isLoading);

    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('No Products Found!'));

      if (_shiftDetails.length != null && _isLoading == false) {
        content = _shift();
      } else if (_isLoading == true) {
        content = Center(
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator());
      }

      if (_shiftDetails.length == 0 && _isLoading == false) {
        content = Center(
            child: Text(
          'No Schedules Found!',
          style: TextStyle(color: Colors.white),
        ));
      }

      return RefreshIndicator(
        onRefresh: model.filter,
        child: content,
      );
    });
  }

  onSearchTextChanged(String fromDate, String toDate) async {

    var splitArr=[];
    splitArr = fromDate.split(" ");
    print(splitArr[0]);
    print(splitArr[1]);
    print(splitArr[2]);
    print(splitArr[3]);

    String from=splitArr[3]+"-"+splitArr[1]+"-"+splitArr[2];


    splitArr=[];
    splitArr = toDate.split(" ");
    print(splitArr[0]);
    print(splitArr[1]);
    print(splitArr[2]);
    print(splitArr[3]);

    String to=splitArr[3]+"-"+splitArr[1]+"-"+splitArr[2];
    print("from");
    print(from);
    print("to");
    print(to);


    widget.model
        .fetchUser(new http.Client(), from, to)
        .then((String) {
      parseData(String);
      _isLoading = false;
    });
//    _shiftDetails.forEach((shiftDetails) {
//      if (shiftDetails.address.contains(text) ||
//          shiftDetails.candidateId.contains(text))
//        _searchResult.add(shiftDetails);
//    });
//
//    setState(() {});
  }

  resetSchedule()async {
    widget.model
        .fetchUser(new http.Client(), currentDate, toDate)
        .then((String) {
      parseData(String);
      _isLoading = false;
    });
  }
}
