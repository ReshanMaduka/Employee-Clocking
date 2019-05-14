import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import './widgets/helpers/custom_route.dart';


import './pages/auth.dart';
import './pages/home.dart';
import './scoped_models/main.dart';


void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
//  MapView.setApiKey(apiKey);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.userSubject.listen((bool isAuthenticated) {
      print(isAuthenticated);
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building main page');
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyList',
        // debugShowMaterialGrid: true,
        theme: ThemeData(

            hintColor: Colors.white,
            inputDecorationTheme: new InputDecorationTheme(
                labelStyle: new TextStyle(color: Colors.white))
//            backgroundColor: Colors.red,

//            primarySwatch: Colors.white30,
//            accentColor: Colors.white,
//            buttonColor: Colors.deepPurple
        ),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) =>
          !_isAuthenticated ? AuthPage() : HomePage(_model),
        },
//        onGenerateRoute: (RouteSettings settings) {
//          if (!_isAuthenticated) {
//            return MaterialPageRoute<bool>(
//              builder: (BuildContext context) => AuthPage(),
//            );
//          }
//          final List<String> pathElements = settings.name.split('/');
//          if (pathElements[0] != '') {
//            return null;
//          }
//          if (pathElements[1] == 'product') {
//            final String productId = pathElements[2];
//            final Product product =
//            _model.allProducts.firstWhere((Product product) {
//              return product.id == productId;
//            });
//            return CustomRoute<bool>(
//              builder: (BuildContext context) =>
//              !_isAuthenticated ? AuthPage() : HomePage(_model),
//            );0
//          }
//          return null;
//        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : HomePage(_model));
        },
      ),
    );
  }

}
