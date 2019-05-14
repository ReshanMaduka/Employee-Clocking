import 'package:flutter/material.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

import 'package:flutter_alert/flutter_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';

class Profile extends StatefulWidget {
  final MainModel model;

  Profile(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<Profile> {
  String _fullName = '';
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _mobile = '';
  String _gender = '';
  String _Address = '';
  String _userImage;

  List<Key> keys = [
    Key("Network"),
    Key("NetworkDialog"),
    Key("Flare"),
    Key("FlareDialog"),
    Key("Asset"),
    Key("AssetDialog")
  ];

  @override
  initState() {
//    widget.model.fetchProducts();
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = (prefs.getString('firstName') ?? '');
      _lastName = (prefs.getString('lastName') ?? '');
      _fullName = _firstName + ' ' + _lastName;
      _email = (prefs.getString('Email') ?? '');
      _mobile = (prefs.getString('mobileNo') ?? '');
      _gender = (prefs.getString('sex') ?? '');
      _Address = (prefs.getString('Address') ?? '');
      _userImage = (prefs.getString('emplayeeImage') ?? '');
//      _userImage =
//          'https://assets1.biggerpockets.com/uploads/social_user/user_avatar/464575/big_1453224347-avatar-louisc10.jpg';
    });
  }

  Widget _Details() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Full Name',
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'E-mail',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Mobile',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Gender',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Address',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        new Flexible(
          child: Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      _fullName,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      _email,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      _mobile,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      _gender,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      _Address,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _img() {
    if (_userImage == '') {
      return new CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: new AssetImage('assets/bg@300x.png'),
        radius: 80.0,
        child: CircleAvatar(
          radius: 60.0,
          backgroundImage: AssetImage('assets/user.png'),
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      return new CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: new AssetImage('assets/bg@300x.png'),
        radius: 80.0,
        child: CircleAvatar(
          radius: 60.0,
          child: CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/user.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
//          child: Image.asset('assets/test.png'),
      );
    }
  }

  Widget _showLogo() {
    return new Center(
      child: new ResponsiveContainer(
        heightPercent: 25.0,
        widthPercent: 45.0,
        child: Hero(
          tag: 'hero',
          child: Padding(
              padding: EdgeInsets.fromLTRB(.0, 0.20, 0.0, 0.0), child: _img()),
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    final double deviceWidth = MediaQuery.of(context).size.height;
    print(deviceWidth);
    return new Center(
        child: new Container(
      child: new ResponsiveContainer(
        heightPercent: 45.0,
        widthPercent: MediaQuery.of(context).size.width,
        child: new Container(
          padding: EdgeInsets.only(top: 30.0, left: 30.0),
          child: _Details(),
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF545172),
                const Color(0xFF545172),
                const Color(0xFF545172),
                const Color(0xFF545172),
                const Color(0xFF545172),
                const Color(0xFF545172),
                const Color(0xFF464360),
                const Color(0xFF464360),
                const Color(0xFF464360),
              ], // whitish to gray
//              tileMode: TileMode.mirror, // repeats the gradient over the canvas
            ),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0)),
          ),
//          height: 350.0,
        ),
      ),
    ));
  }

//  return ScopedModelDescendant(
//  builder: (BuildContext context, Widget child, MainModel model) {
//  showDialog(
//  context: context,builder: (_) => NetworkGiffyDialog(
//  image: Image(image: AssetImage('')),
//  title: Text('Men Wearing Jackets',
//  style: TextStyle(
//  fontSize: 22.0, fontWeight: FontWeight.w600),
//  ),
//  description: Text('This is a men wearing jackets dialog box.This library helps you easily create fancy giffy dialog.',
//  textAlign: TextAlign.center,
//  style: TextStyle(),
//  ),
//  onOkButtonPressed: () {},
//  ) );
//  });

  _onAlertButtonsPressed(context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {});
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return new Scaffold(
        backgroundColor: const Color(0xFF242133),
        appBar: AppBar(
          title: Text('Profile',style: TextStyle(fontSize: 24.0)),
          elevation: 0.0,
          backgroundColor: const Color(0xFF242133),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
//            tooltip: 'Restitch it',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AssetGiffyDialog(
                            key: keys[5],
                            buttonCancelText: Text('No',style: TextStyle(fontSize:20.0,color: Colors.white),),
                            buttonRadius: 20.0,
                            buttonCancelColor: Colors.red,
                            buttonOkText: Text('Yes',style: TextStyle(fontSize:20.0,color: Colors.white),),
                            image: Image.asset(
                              "assets/logout.gif",
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              'Come Back Soon',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.w800),
                            ),
                            description: Text(
                              'Are you sure you want to Log out? ',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            onOkButtonPressed: () {
                              model.logout();
                              Navigator.pushReplacementNamed(context, '/');
                            },
                          ));
                }

//                    _showQuestionDialog();
////                    model.logout();
////                    Navigator.pushReplacementNamed(context, '/');
//                  },
                ),
          ],
        ),
        body: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showLogo(),
            new Center(
              child: Text(
                _fullName,
                style: TextStyle(color: Colors.white),
              ),
            ),
            new Center(
              child: Text(
                'test test test',
                style: TextStyle(color: Colors.deepPurple[200]),
              ),
            ),
//          new TextField(),
            Expanded(
              child: new Container(),
            ),
            Column(
              children: <Widget>[_buildProductsList()],
            )
          ],
        ),
      );
    });
  }
}
