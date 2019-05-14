import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/ui_elements/adapative_progress_indicator.dart';
import '../scoped_models/main.dart';
import '../models/auth.dart';

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

  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(0.0, -1.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/Asset 18@300x.png'),
    );
  }

  Widget _buildUserNameTextField() {
    final theme = Theme.of(context);
    return TextFormField(
      decoration: new InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'User Name',
          labelStyle: theme.textTheme.caption
              .copyWith(color: Colors.white, fontSize: 17),
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
              borderSide: new BorderSide(
                  color: Colors.white
              )
          ),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
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
                                          new BorderRadius.circular(30.0)),
                                  padding: EdgeInsets.all(18.0),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text(
                                    _authMode == AuthMode.Login
                                        ? 'Log in '
                                        : 'SIGNUP',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  onPressed: () =>
                                      _submitForm(model.authenticate),
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
