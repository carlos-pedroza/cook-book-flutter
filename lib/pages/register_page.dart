import 'package:flutter/material.dart';
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

  TextStyle style() {
    return TextStyle(fontFamily: 'Verdana, Geneva, sans-serif', fontSize: 18.0);
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
          if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value) ==
              true) {
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
    return InkWell(
      onTap: () {
        save(model);
      },
      child: new Container(
        margin: EdgeInsets.only(top: 30.0),
        height: 50.0,
        decoration: new BoxDecoration(
          color: Colors.blueAccent,
          border: new Border.all(color: Colors.white, width: 2.0),
          borderRadius: new BorderRadius.circular(20.0),
        ),
        child: new Center(
          child: new Text(
            'Register',
            style: new TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
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
              buttonRegister(context, model),
            ],
          ),
        ),
        margin: EdgeInsets.all(10.0),
      );
    });
  }

  void save(MainModel model) {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() == true) {
      model.signup(model.user).then((Message response) {
        if(response.result==true) {
          Navigator.pop(context);
        }
        else {
          
        }
        print(response.message);
      });
    } else {
      print('Fail');
    }
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
