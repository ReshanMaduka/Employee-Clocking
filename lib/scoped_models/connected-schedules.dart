import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../models/user.dart';
import '../models/auth.dart';
import '../models/Shifts.dart';

mixin ConnectedScheduleModel on Model {
  List<Shift> _shifts = [];
  String _selProductId;
  User _authenticatedUser;

  bool _isLoading = false;
}

mixin ShiftModel on ConnectedScheduleModel {
  User get user {
    return _authenticatedUser;
  }

  List<Shift> get allShift {
    return List.from(_shifts);
  }

  Future<List<Shift>> fetchUsers() async {
    var response = await http.get(
        'https://labourbank.com.au/mobileAPI/api/shifts/CHAN0000011473/2019-05-12/2019-05-17',
        headers: {
          'authorization': 'Bearer' + ' ' + _authenticatedUser.Token,
          'content-type': 'application/json'
        });
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Shift> listOfUsers = items.map<Shift>((json) {
        return Shift.fromJson(json);
      }).toList();
      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }

//    List<Shift> shifts = [];
//    var response = await http.get(
//        'https://labourbank.com.au/mobileAPI/api/shifts/CHAN0000011473/2019-05-12/2019-05-17',
//        headers: {
//          'authorization': 'Bearer' + ' ' + _authenticatedUser.Token,
//          'content-type': 'application/json'
//        });
//    var jsonData = json.decode(response.body);
//    List<dynamic> usersData = new List<dynamic>.from(jsonData);
//
//    for (var user in usersData) {
//      Shift newshift = Shift(shiftId: user["shiftId"].toString(),
//          candidateId: user["usersData"].toString(),
//          clientId: user["usersData"].toString(),
//          shiftDate: user["shiftDate"],
//          shiftStart: user["shiftStart"],
//          shiftEnd: user["shiftEnd"],
//          address: user["address"],
//          latitude: user["latitude"].toString(),
//          longitude: user["longitude"]);
//      shifts.add(newshift);
//    }
//    print("ffff");
//    print(shifts);
//    return Future.value(shifts);
  }

//  Future<Null> fetchShift({onlyForUser = false, clearExisting = false}) {
//    _isLoading = true;
//    if (clearExisting) {
//      _shifts = [];
//    }
//
//    print("call");
//
//    notifyListeners();
//    return http.get(
//        'https://labourbank.com.au/mobileAPI/api/shifts/CHAN0000011473/2019-05-12/2019-05-17',
//        headers: {
//          'authorization': 'Bearer' + ' ' + _authenticatedUser.Token,
//          'content-type': 'application/json'
//        }).then<Null>((http.Response response) {
//
//
//      final List<Shift> fetchedShiftList = [];
//      var streetsFromJson = json.decode(response.body);
//
//      List<dynamic> streetsList = new List<dynamic>.from(streetsFromJson);
//
//      List<dynamic> usersData = new List<dynamic>.from(streetsFromJson);
//
//      if (streetsList == null) {
//        _isLoading = false;
//        notifyListeners();
//        return;
//      }
//
//      for (var user in usersData) {
//      final Shift newShift = Shift(
//            shiftId: user["shiftId"].toString(),
//            candidateId: user["usersData"].toString(),
//            clientId: user["usersData"].toString(),
//            shiftDate: user["shiftDate"],
//            shiftStart: user["shiftStart"],
//            shiftEnd: user["shiftEnd"],
//            address: user["address"],
//            latitude: user["latitude"].toString(),
//            longitude: user["longitude"]);
//        fetchedShiftList.add(newShift);
//      }
////      print("fg");
//
////      print(fetchedShiftList);
//
//      _shifts = onlyForUser
//          ? fetchedShiftList.where((Shift shift) {
//        return shift.candidateId == _authenticatedUser.Id;
//      }).toList()
//          : fetchedShiftList;
//      _isLoading = false;
//      notifyListeners();
////      _selProductId = null;
//    }).catchError((error) {
//      _isLoading = false;
//      notifyListeners();
//      return;
//    });
//  }
}

mixin UtilityModel on ConnectedScheduleModel {
  bool get isLoading {
    return _isLoading;
  }
}

mixin UserModel on ConnectedScheduleModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String username, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'http://labourbank.com.au/mobileAPI/api/login',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    bool hasError = true;
    String message = 'Something went wrong.';
//    print(responseData);
    final Map<String, dynamic> userDetail = responseData['data'];
//    print(userDetail);
    if (response.statusCode == 200) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          Id: userDetail['candidateId'],
          firstName: userDetail['firstName'],
          lastName: userDetail['lastName'],
          Age: '30',
          Email: userDetail['email'],
          Token: userDetail['api_token'],
          Address: userDetail['address'],
          mobileNo: userDetail['mobileNo'],
          Gender: userDetail['sex'],
          Image: userDetail['emplayeeImage']);
      _userSubject.add(true);

      print(userDetail);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Id', userDetail['candidateId']);
      prefs.setString('firstName', userDetail['firstName']);
      prefs.setString('lastName', userDetail['lastName']);
      prefs.setString('Age', '30');
      prefs.setString('Email', userDetail['email']);
      prefs.setString('Token', userDetail['api_token']);
      prefs.setString('Address', userDetail['address']);
      prefs.setString('mobileNo', userDetail['mobileNo']);
      prefs.setString('sex', userDetail['sex']);
      prefs.setString('emplayeeImage', userDetail['emplayeeImage']);
    } else {
      message = 'Please Check Your Username & Password.';
    }
    _isLoading = false;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('Email'));
    return {'success': !hasError, 'message': message};
  }

  Future<bool> logout() async {
    notifyListeners();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final http.Response response = await http
          .post('http://labourbank.com.au/mobileAPI/api/logout', headers: {
        'authorization': 'Bearer' + ' ' + pref.getString('Token'),
        'content-type': 'application/json'
      });
      if (response.statusCode != 200) {
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
      _authenticatedUser = null;
      _userSubject.add(false);
      pref.remove('Id');
      pref.remove('firstName');
      pref.remove('lastName');
      pref.remove('Age');
      pref.remove('Email');
      pref.remove('Token');
      pref.remove('Address');
      pref.remove('mobileNo');
      pref.remove('sex');
      pref.remove('emplayeeImage');
      return true;
    } catch (error) {
      notifyListeners();
      return false;
    }
  }
}
