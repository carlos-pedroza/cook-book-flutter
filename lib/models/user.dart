import 'package:flutter/material.dart';

class User {
  String id;
  String email;
  String password;
  String idToken;
  int expiresIn;
  DateTime expiresDate;

  User(
      {this.id = "",
      @required this.email,
      this.password,
      this.idToken,
      this.expiresIn,
      this.expiresDate}) {
    if (expiresDate == null) {
      if (this.expiresIn != null) {
        expiresDate = DateTime.now().add(Duration(seconds: expiresIn));
      }
    }
  }

  bool isExpired() {
    DateTime now = DateTime.now();
    return expiresDate.isAfter(now);
  }
}
