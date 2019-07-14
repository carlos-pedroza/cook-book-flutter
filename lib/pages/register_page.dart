import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:convert';
import '../scope_models/main_model.dart';
import '../utils/message.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  MainModel _model;

  TextStyle style() {
    return TextStyle(fontFamily: 'Verdana, Geneva, sans-serif', fontSize: 18.0);
  }

  @override
  initState() {
    super.initState();
  }

  static InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      errorStyle: TextStyle(
          fontFamily: 'Verdana, Geneva, sans-serif',
          fontSize: 16.0,
          color: Colors.white),
    );
  }

  Widget email(MainModel model) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          model.user.email = value;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'The Email is required!';
          }
          if (!RegExp(model.emailValid).hasMatch(value) == true) {
            return 'The Email should be in a correct format!';
          }
        },
        style: style(),
        decoration: inputDecoration('email'),
      ),
    );
  }

  Widget password(MainModel model) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          model.user.password = value;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return 'The Password is required!';
          }
        },
        style: style(),
        decoration: inputDecoration('password'),
      ),
    );
  }

  Widget confirmPassword(MainModel model) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {},
        validator: (String value) {
          if (value.isEmpty) {
            return 'The Confirmation of Password is required!';
          }
          if (value != model.user.password) {
            return 'The password and his confirmation are not equal!';
          }
        },
        style: style(),
        decoration: inputDecoration('confirm password'),
      ),
    );
  }

  Widget buttonRegister(BuildContext context, MainModel model) {
    Widget button = CupertinoButton.filled(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      child: Container(
        child: Text('SIGNUP'),
      ),
      onPressed: () {
        save(model).then((value) {
          model.isLoading = false;
          if (value) {
            Navigator.pop(context);
          }
        });
      },
    );

    return Center(
      child: !model.isLoading ? button : CircularProgressIndicator(),
    );
  }

  form(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              email(model),
              password(model),
              confirmPassword(model),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: buttonRegister(context, model),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.all(10.0),
      );
    });
  }

  Future<bool> save(MainModel model) async {
    Message _response;
    bool _resultBnd = false;
    try {
      _formKey.currentState.save();
      if (_formKey.currentState.validate() == true) {
        _response = await model.signup(model.user);
        if (_response.result == true) {
          _resultBnd = true;
        } else {
          dialogError(_response);
        }
        print(_response.message);
      }
      return _resultBnd;
    } catch (e) {
      print(e);
    }
  }

  void dialogError(Message _response) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      backgroundColor: Color.fromRGBO(61, 71, 83, 1),
      body: form(context),
    );
  }
}
