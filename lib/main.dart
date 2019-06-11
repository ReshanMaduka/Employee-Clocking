import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import './widgets/helpers/custom_route.dart';
import './shared/global_config.dart';


import './pages/auth.dart';
import './pages/home.dart';
import './pages/map.dart';
import './pages/home.dart';
import './pages/release_shift.dart';
import './scoped_models/main.dart';


void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  MapView.setApiKey(apiKey);
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


  void createSnackBar(context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Pups neeed names!'),
      ),
    );
  }


//  Widget _snackBar(BuildContext context){
//          final snackBar = SnackBar(
//            content: Text('Yay! A SnackBar!'),
//            action: SnackBarAction(
//              label: 'Undo',
//              onPressed: () {
//                // Some code to undo the change!
//              },
//            ),
//          );
//
//          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
////          Scaffold.of(context).showSnackBar(snackBar);
//        }

  @override
  Widget build(BuildContext context) {
    print('building main page');
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Clocking',
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            canvasColor: Colors.transparent,
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
          '/map': (BuildContext context) =>
          !_isAuthenticated ? MapPage(_model): MapPage(_model),
         '/schedule': (BuildContext context) =>
          !_isAuthenticated ? ReleasedShiftPage(_model) : ReleasedShiftPage(_model),
          '/home': (BuildContext context) =>
          !_isAuthenticated ? HomePage(_model) : HomePage(_model),
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
