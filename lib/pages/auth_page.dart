import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import '../scope_models/main_model.dart';
import '../scope_models/user_model.dart';
import '../utils/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/global.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextStyle style =
      TextStyle(fontFamily: 'Verdana, Geneva, sans-serif', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    Widget emailField(MainModel model) {
      return TextFormField(
        initialValue: model.user.email,
        onSaved: (value) {
          model.user.email = value.toLowerCase();
        },
        validator: (String email) {
          if (email.isEmpty) {
            return 'The Email is required!';
          }
          if (!RegExp(model.emailValid).hasMatch(email) == true) {
            return 'The Email should be in a correct format!';
          }
        },
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(255, 255, 255, 0.7),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      );
    }

    Widget passwordField(MainModel model) {
      return TextFormField(
        onSaved: (value) {
          model.user.password = value;
        },
        validator: (String password) {
          if (password.isEmpty) {
            return 'The password is required';
          }
        },
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(255, 255, 255, 0.7),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      );
    }

    final assetsImage = new AssetImage(
        "assets/images/logo100.png"); //<- Creates an object that fetches an image.
    final image = new Image(image: assetsImage, fit: BoxFit.fill);

    bool _rememberUser = false;

    final _rememberUserSwitch = Container(
      margin: EdgeInsets.only(top: 25.0, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(50.0),
          topRight: const Radius.circular(50.0),
          bottomLeft: const Radius.circular(50.0),
          bottomRight: const Radius.circular(50.0),
        ),
      ),
      child: SwitchListTile(
        value: _rememberUser,
        onChanged: (bool value) {
          setState(() {
            _rememberUser = value;
          });
        },
        title: Text(
          'Remember this user?',
          style: TextStyle(color: Colors.blueGrey, fontSize: 14),
        ),
      ),
    );

    Widget register(MainModel model) {
      return FlatButton(
        child: Text(
          'SIGNUP',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          model.clearUser();
          Navigator.pushNamed(context, '/register').then((_user) {});
        },
      );
    }

    final formBox = ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                      bottomLeft: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: SizedBox(
                    height: 100.0,
                    child: image,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField(model),
                SizedBox(height: 25.0),
                passwordField(model),
                SizedBox(height: 35.0),
                !model.isLoading
                    ? loginButton(
                        context_main: context,
                        style: style,
                        formKey: _formKey,
                        model: model)
                    : CircularProgressIndicator(),
                _rememberUserSwitch,
                SizedBox(
                  height: 15.0,
                ),
                register(model),
              ],
            ),
          ),
        ),
      );
    });

    String imgH = "";
    String imgV = "";

    if (MediaQuery.of(context).size.width >=
        MediaQuery.of(context).size.height) {
      imgH = MediaQuery.of(context).size.width.toString();
      imgV = MediaQuery.of(context).size.height.toString();
    } else {
      imgV = MediaQuery.of(context).size.width.toString();
      imgH = MediaQuery.of(context).size.height.toString();
    }
    imgV = imgV.substring(0, imgV.length - 2);
    imgH = imgH.substring(0, imgH.length - 2);

    final imageBackUrl = "https://picsum.photos/id/160/" + imgH + "/" + imgV;

    return Scaffold(
      backgroundColor: Color.fromRGBO(61, 71, 83, 1),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(imageBackUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: formBox,
      ),
    );
  }

  Widget loginButton({BuildContext context_main, style, formKey, model}) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) =>
            MaterialButton(
          minWidth: MediaQuery.of(context_main).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            _submit(context_main, formKey, model.user, model);
          },
          child: Text("Login",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

void SnackOk(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('Welcome!'),
    backgroundColor: Colors.red,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

void SnackError(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('Invalid!'),
    backgroundColor: Colors.red,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

void _submit(BuildContext context, GlobalKey<FormState> _formKey, User user,
    MainModel model) {
  if (_formKey.currentState.validate() == true) {
    _formKey.currentState.save();
    model.verifyPassword(model.user).then((Message resPayload) {
      if (resPayload.result == true) {
        model.login(model.user.email, resPayload.payload);
        print(resPayload.payload);
        SharedPreferences.getInstance().then((SharedPreferences prefs) {
          prefs.setString(Global.token, model.authUser.idToken);
          prefs.setString(Global.userID, model.authUser.id);
          prefs.setString(Global.email, model.authUser.email);
        });
        model.getHttpProducts().then((bool res) {});
        Navigator.pushNamed(context, '/home').then((_user) {});
      } else {
        dialogError(context, resPayload);
        print(resPayload);
      }
    });
  } else {
    SnackError(context);
  }
}

void dialogError(BuildContext context, Message _response) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ocurrio un error:"),
          content: Text(_response.message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
