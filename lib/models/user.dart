import 'package:flutter/material.dart';

class User {
  String id;
  String email;
  String password;
  String idToken;
  int expiresIn;

  User({ this.id = "", @required this.email, this.password, this.idToken, this.expiresIn });
}