import 'package:flutter/material.dart';

class User {
  String id;
  String email;
  String password;
  String idToken;
  int expiresIn;
  DateTime logonDate;

  User(
      {this.id = "",
      @required this.email,
      this.password,
      this.idToken,
      this.expiresIn,
      this.logonDate}) {
    if (logonDate == null) {
      if (this.expiresIn != null) {
        logonDate = DateTime.now().add(Duration(seconds: expiresIn));
      }
    }
  }
}
