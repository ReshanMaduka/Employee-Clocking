import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/ui_elements/adapative_progress_indicator.dart';
import '../scoped_models/main.dart';
import '../models/auth.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  final Map<String, dynamic> _formData = {
    'username': null,
    'password': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  BuildContext scaffoldContext;
  String conState;
  StreamSubscription<ConnectivityResult> _subscription;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  void _showSnackBar() {
    _scaffoldstate.currentState.showSnackBar(new SnackBar(
      content: new Text('No Connection',textAlign: TextAlign.center),
      backgroundColor: Color(0xFFE74C3C),
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    ));
  }

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
        conState=result.toString();
        print(conState);
        _showSnackBar();
      } else {
        conState=result.toString();
        print(conState);
      }
      // Got a new connectivity status!
    });
  }

  @override
  dispose() {
    super.dispose();
    _subscription.cancel();
    print("dispose");
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/Asset18@300x.png'),
    );
  }

  Widget _buildUserNameTextField() {
    final theme = Theme.of(context);
    return TextFormField(
      decoration: new InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        hintText: 'User Name',
        labelStyle:
            theme.textTheme.caption.copyWith(color: Colors.white, fontSize: 17),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter a username';
        }
      },
      onSaved: (String value) {
        _formData['username'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    final theme = Theme.of(context);
    return TextFormField(
      decoration: InputDecoration(
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Password',
          labelStyle: theme.textTheme.caption
              .copyWith(color: Colors.white, fontSize: 17)),
      obscureText: true,
      style: TextStyle(color: Colors.white),
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

//  _onAlertButtonsPressed(BuildContext context) {
//    Alert(
//      context: context,
//      type: AlertType.warning,
//      title: "Come Back Soon",
//      desc: "Are you sure you want to Log out? ",
//      buttons: [
//        DialogButton(
//            child: Text(
//              "Yes",
//              style: TextStyle(color: Colors.white, fontSize: 20),
//            ),
//            onPressed: () {model.logout();
//            Navigator.pushReplacementNamed(context, '/');},
//            color: Color(0xFF00A8FF)
//        ),
//        DialogButton(
//          child: Text(
//            "No",
//            style: TextStyle(color: Colors.white, fontSize: 20),
//          ),
//          onPressed: () => Navigator.pop(context),
//          color: Color(0xFFE74C3C),
//        )
//      ],
//    ).show();
//  }


  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await authenticate(
        _formData['username'], _formData['password'], _authMode);
    if (successInformation['success']) {
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      Alert(
        context: context,
        type: AlertType.warning,
        style: AlertStyle(animationDuration: Duration(milliseconds: 300),animationType: AnimationType.fromBottom),
//        image: Image.asset('assets/logo.png'),
        title: 'An Error Occurred!',
        desc: successInformation['message'],
        buttons: [
          DialogButton(
            child: Text(
              "Okay,Got It",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//
////          _onAlertButtonsPressed(context);
////          return AlertDialog(
////            title: Text('An Error Occurred!'),
////            content: Text(successInformation['message']),
////            actions: <Widget>[
////              FlatButton(
////                child: Text('Okay'),
////                onPressed: () {
////                  Navigator.of(context).pop();
////                },
////              )
////            ],
////          );
//        },
//      );
    }
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(.0, 0.20, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      key: _scaffoldstate,
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.bottomCenter,
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _showLogo(),
                    SizedBox(
                      height: 2.0,
                    ),
                    new Text(
                      'Emp Clock',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    _buildUserNameTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return model.isLoading
                            ? AdaptiveProgressIndicator()
                            : Row(children: <Widget>[
                                Expanded(
                                    child: RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        padding: EdgeInsets.all(18.0),
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        child: Text(
                                          _authMode == AuthMode.Login
                                              ? 'Log in '
                                              : 'SIGNUP',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                        onPressed: () {
                                          if (conState == "ConnectivityResult.none") {
                                           _showSnackBar();
                                          } else {
                                            _submitForm(model.authenticate);
                                          }
                                        }
//
                                        )),
                              ]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
