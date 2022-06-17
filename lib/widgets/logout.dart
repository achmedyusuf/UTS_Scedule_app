import 'package:flutter/material.dart';
import 'package:project_app/screens/login_page.dart';
import 'package:project_app/theme/colors/light_colors.dart';

import '../authentication/sign_in.dart';

class MyLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logout',
      child: GestureDetector(
        onTap: () {
          signOutGoogle();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return LoginPage();
          }), ModalRoute.withName('/'));
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.logout,
            size: 25,
            color: LightColors.kDarkBlue,
          ),
        ),
      ),
    );
  }
}
