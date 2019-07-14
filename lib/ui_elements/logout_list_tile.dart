import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../utils/custom_list_tile.dart';

import '../scope_models/main_model.dart';

class LogoutListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return CustomlistTile(
          icon: Icons.exit_to_app,
          label: 'Logout',
          onTap: () {
            model.logout().then((bool result) {
              Navigator.pushReplacementNamed(context, '/auth');
            });
          },
        );
      },
    );
  }
}
