import 'package:flutter/material.dart';

class User{
  final String Id;
  final String firstName;
  final String lastName;
  final String Age;
  final String Email;
  final String Token;
  final String Address;
  final String mobileNo;
  final String Gender;
  final String Image;

  User({
    @required this.Id,
    @required this.firstName,
    @required this.lastName,
    @required this.Age,
    @required this.Email,
    @required this.Token,
    @required this.Address,
    @required this.mobileNo,
    @required this.Gender,
    @required this.Image
  });
}
