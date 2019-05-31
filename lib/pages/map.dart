import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as geoloc;
import 'package:responsive_container/responsive_container.dart';
import '../models/location_data.dart';
import '../scoped_models/main.dart';



class MapPage extends StatefulWidget {

  final MainModel model;
  MapPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _MapPage();
  }
}

class _MapPage extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

//  final location = geoloc.Location();
//  static const  lat=;
  static LatLng _center = LatLng(
    6.7290,
    79.9067,
  );

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {
     Marker(
        markerId: MarkerId("1"),
        icon: BitmapDescriptor.fromAsset('assets/Asset14@300x.png'),
        position: LatLng(6.7290, 79.9067),
        infoWindow: InfoWindow(title:"You"),
  ),
    Marker(
        markerId: MarkerId("2"),
        icon: BitmapDescriptor.fromAsset('assets/Asset13@300x.png'),
        position: LatLng(6.7881, 79.8913),
        infoWindow: InfoWindow(title: "Client")),

  };

//  void _onAddMarkerButtonPressed() {
//    setState(() {
//      _markers.add(Marker(
//        // This marker id can be anything that uniquely identifies each marker.
//        markerId: MarkerId(_lastMapPosition.toString()),
//        position: _lastMapPosition,
//        infoWindow: InfoWindow(
//          title: 'Really cool place',
//          snippet: '5 Star Rating',
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//      ));
//    });
//  }

  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/schedule');
//          return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCameraMove,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.lens,
                              size: 16.0,
                              color: Color(0xFF3A8DFD),
                            ),
                            onPressed: () {},
                          ),
                          Expanded(
//                      flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text("Alex s.Caraballo",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
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
                              color: Color(0xFF3A8DFD),
                            ),
                            onPressed: () => {},
                          ),
                          Expanded(
//                      flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text(
                                    "1229 instsdvs road Nc 10000, Australias road Nc 10000, Australis",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      new Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.lens,
                              color: Colors.transparent,
                            ),
                            onPressed: () => {},
                          ),
                          Expanded(
//                      flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text("Start Time",
                                    style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 16.0))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: 35.0,
                        height: 35.0,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
//                            Navigator.of(context).pushReplacementNamed('/schedule');
//                            Navigator.pushReplacementNamed(context, '/schedule');
                          },
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.black,
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ],
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
