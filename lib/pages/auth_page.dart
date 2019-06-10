import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String email = "";
  String password = "";
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextStyle style =
      TextStyle(fontFamily: 'Verdana, Geneva, sans-serif', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      onSaved: (value) {
        this.email = value.toLowerCase();
      },
      validator: (String email) {
        if(email.isEmpty) {
          return 'The Email is required!';
        }
        if(!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(email) == true) {
          return 'The Email should be in a correct format!';
        }
        if(!ValidEmail(email)) {
          return 'The email is not valid!';
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
    final passwordField = TextFormField(
      onSaved: (value) {
        this.password = value;
      },
      validator: (String password) {
        if(password.isEmpty) {
          return 'The password is required';
        }
        if(!ValidPassword(password)) {
          return 'The password is incorrect!';
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

    final formBox = Center(
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
              emailField,
              SizedBox(height: 25.0),
              passwordField,
              SizedBox(
                height: 35.0,
              ),
              LoginButton(style, email, password, _formKey),
              _rememberUserSwitch,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );

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
}

class LoginButton extends StatelessWidget {
  TextStyle style;
  String email;
  String password;
  final GlobalKey<FormState> _formKey;

  LoginButton(this.style, this.email, this.password, this._formKey);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if(_formKey.currentState.validate()==true) {
            _formKey.currentState.save();
            SnackOk(context);
            Navigator.pushReplacementNamed(context, '/home');
          }
          else {
            SnackError(context);
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

bool ValidEmail(String email) => (email.trim().toLowerCase()=="carlos.pedrozav@gmail.com");

bool ValidPassword(String password) => (password=='1234');

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
