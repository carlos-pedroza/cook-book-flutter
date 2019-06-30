import '../scope_models/conected_model.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../utils/message.dart';
import '../utils/api_key.dart';

mixin UserModel on ConectedModel {
  String _apiKey = apiKey.key;

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
    _user = value;
    String url =
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${_apiKey}";

    final Map<String, dynamic> authData = {
      'email': _user.email,
      'password': _user.password,
      'returnSecureToken': true
    };
    http.Response response = await http.post(
      url,
      body: json.encode(authData),
    );
    final Map<String, dynamic> result = json.decode(response.body);
    if (result.containsKey("idToken")) {
      notifyListeners();
      return Message(result: true, message: result["idToken"]);
    } else if (result.containsKey("error")) {
      return  Message(result: false, message: result["error"]["message"]);
    } else {
      return Message(result: false, message: null);
    }
  }
}
