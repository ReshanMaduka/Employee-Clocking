import 'package:flutter/material.dart';

class Shift {
  final String shiftId;
  final String candidateId;
  final String clientId;
  final String shiftDate;
  final String shiftStart;
  final String shiftEnd;
  final String address;
  final String latitude;
  final String longitude;

  Shift({
    @required this.shiftId,
    @required this.candidateId,
    @required this.clientId,
    @required this.shiftDate,
    @required this.shiftStart,
    @required this.shiftEnd,
    @required this.address,
    @required this.latitude,
    @required this.longitude});


  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      shiftId: json['shiftId'].toString(),
      candidateId: json['candidateId'],
      clientId:json['clientId'].toString(),
      shiftDate: json['shiftDate'],
      shiftStart: json['shiftStart'],
      shiftEnd: json['shiftEnd'],
      address: json['address'],
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString()
    );
  }
}
