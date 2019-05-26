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

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      onChanged: (value) {
        setState(() {
          this.email = value;
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
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
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
          style: TextStyle(color: Colors.blueGrey, fontSize: 14 ),
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
              loginButon,
              _rememberUserSwitch,
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );

    final imageBackUrl = "https://picsum.photos/id/160/" +
        MediaQuery.of(context).size.width.toString().replaceAll('.0', '') +
        "/" +
        MediaQuery.of(context).size.height.toString().replaceAll('.0', '');

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
