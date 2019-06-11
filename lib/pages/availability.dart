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

class AvailabilityPage extends StatefulWidget {
  final MainModel model;

  AvailabilityPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _AvailabilityPage();
  }
}


class _AvailabilityPage extends State<AvailabilityPage> with TickerProviderStateMixin {
  Modal popupModal = new Modal();
  final formats = {
    InputType.date: DateFormat("EEEE, M d, yyyy"),
    InputType.time: DateFormat("HH:mm"),
  };
  InputType inputType = InputType.date;
  bool editable = false;
  DateTime date;
  bool _isLoading = true;

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
//                                controller: _startDate,
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
//                                controller: _endDate,
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
//                                    _txtSearch.text = _startDate.text +"-"+ _endDate.text;
                                  });
//                                  onSearchTextChanged(
//                                      _startDate.text, _endDate.text);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF242133),
        appBar: AppBar(
          title: Text("Availability",style: TextStyle(fontSize: 24.0)),
          elevation: 0.0,
          backgroundColor: const Color(0xFF242133),
        ),
        body: new Container(
          child: ListView(
            children: <Widget>[
              new Container(
                color: Color(0xFF242133),
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: new TextField(
//                  controller: _txtSearch,
                    style: TextStyle(color: Colors.white),
//                    autofocus: false,
//                    onTap: () {
//                      FocusScope.of(context).requestFocus(new FocusNode());
////                    _mainBottomSheet(context);
//                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
