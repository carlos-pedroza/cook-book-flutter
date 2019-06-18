import 'package:flutter/material.dart';

class CustomlistTile extends StatelessWidget {
  IconData _icon;
  String _label;
  Function _onTap;

  CustomlistTile({icon: Icons.account_circle, label: "", onTap: Function}) {
    this._icon = icon;
    this._label = label;
    this._onTap = onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Row(
            children: <Widget>[
              Container(
                child: Icon(_icon),
                padding: EdgeInsets.all(16.0),
              ),
              Expanded(
                child: Container(
                  child: Text(_label),
                  padding: EdgeInsets.all(16.0),
                ),
              ),
              Container(
                child: Icon(Icons.arrow_right),
                padding: EdgeInsets.all(16.0),
              ),
            ],
          ),
          onTap: this._onTap,
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}
