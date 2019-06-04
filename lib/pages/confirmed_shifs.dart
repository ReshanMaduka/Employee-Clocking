import 'package:flutter/material.dart';
import '../models/shift.dart';
import 'dart:async';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import 'package:connectivity/connectivity.dart';
import '../models/Shifts.dart';

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
  Shift shift;
  List shifts;

  @override
  void initState() {
    widget.model.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        backgroundColor: Color(0xFF242133),
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xFF242133),
          title: Text('Confirmed Shifts', style: TextStyle(fontSize: 24.0)),
        ),
        body: new Container(
          child: new Column(children: <Widget>[
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
            new Expanded(
                child: FutureBuilder<List<Shift>>(
              future: widget.model.fetchUsers(),
               builder: (context, snapshot) {
                 if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                 return ListView(
                   children: snapshot.data
                       .map((shift) => Card(
                     elevation: 0.0,
                     color: Color(0xFF242133),
                     margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                     child: new InkWell(
                       onTap: () {
                         Navigator.pushReplacementNamed(context, '/map');
                       },
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           new Padding(
                             padding: new EdgeInsets.all(2.0),
                             child: new Text(" "+shift.shiftDate+" "+shift.shiftStart+" - "+shift.shiftEnd,
//                    textAlign: TextAlign.left,
                                 style: TextStyle(
                                     color: Color(0xFF7674A8),fontSize: 15.0, fontWeight: FontWeight.bold)),
                           ),
                           new Container(
                             margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(18.0),
                                 color: Color(
                                   0xFF37334D,
                                 )),
                             child: ListTile(
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
                                               child: Text(shift.address,
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
                                               child: Text(shift.candidateId,
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
                   ),
                   )
                       .toList(),
                 );
               }
            ))
          ]),
        ),
      ),
    );
  }
}
