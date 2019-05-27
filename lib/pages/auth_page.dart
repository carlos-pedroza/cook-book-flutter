import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String email = "";
  String password = "";

  final TextStyle style =
      TextStyle(fontFamily: 'Verdana, Geneva, sans-serif', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      onChanged: (value) {
        setState(() {
          this.email = value.toLowerCase();
        });
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
    final passwordField = TextField(
      onChanged: (value) {
        setState(() {
          this.password = value;
        });
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
      child: Container(
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
              LoginButton(style, email, password),
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
    imgV = imgV.substring(0, imgV.length-2);
    imgH = imgH.substring(0, imgH.length-2);

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

  LoginButton(this.style, this.email, this.password);

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
          if (email == "carlos.pedrozav@gmail.com" &&
              password == "carlos1970") {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            final snackBar = SnackBar(
              content: Text('Invalid user or password'),
              backgroundColor: Colors.red,
            );
            Scaffold.of(context).showSnackBar(snackBar);
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
