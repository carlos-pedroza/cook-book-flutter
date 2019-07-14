import '../scope_models/conected_model.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../utils/message.dart';
import '../utils/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/global.dart';

mixin UserModel on ConectedModel {
  final String _verifyPassword =
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${ApiKey.key}";
  final String _signup =
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${ApiKey.key}";
  final String emailValid =
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  User _user = User(email: "", password: "");
  User get user {
    return _user;
  }

  set user(User value) {
    _user = value;
  }

  clearUser() {
    _user.email = "";
    _user.password = "";
  }

  Future<Message> signup(User value) async {
    isLoading = true;
    notifyListeners();
    _user = value;

    final Map<String, dynamic> authData = {
      'email': _user.email,
      'password': _user.password,
      'returnSecureToken': true
    };
    http.Response response = await http.post(
      _signup,
      body: json.encode(authData),
    );
    final Map<String, dynamic> result = json.decode(response.body);
    isLoading = false;
    if (result.containsKey("idToken")) {
      notifyListeners();
      return Message(result: true, message: result["idToken"]);
    } else if (result.containsKey("error")) {
      return Message(result: false, message: result["error"]["message"]);
    } else {
      return Message(result: false, message: null);
    }
  }

  Future<Message> verifyPassword(User user) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> reqPayload = {
      "email": user.email,
      "password": user.password,
      "returnSecureToken": true
    };
    http.Response res = await http.post(
      _verifyPassword,
      headers: {"Content-Type": "application/json"},
      body: json.encode(reqPayload),
    );

    isLoading = false;
    notifyListeners();
    Map<String, dynamic> resPayload = json.decode(res.body);
    if (resPayload.containsKey("idToken")) {
      return Message(result: true, message: resPayload["idToken"], payload: resPayload);
    } else if (resPayload.containsKey("error")) {
      return Message(result: false, message: resPayload["error"]["message"]);
    } else {
      return Message(result: false, message: null);
    }
  }

  void login(String _email, Map<String, dynamic> payload) {
    authUser= User(id: payload["localId"], email: _email, password: "", idToken: payload["idToken"], expiresIn: int.parse(payload["expiresIn"] as String) );
    launchTest();
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authUser = null;
    prefs.remove(Global.userID);
    prefs.remove(Global.email);
    prefs.remove(Global.token);

    return true;
  }
}
