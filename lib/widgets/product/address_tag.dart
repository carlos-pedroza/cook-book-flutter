import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
    String address;

    AddressTag(this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text(address),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
