import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/ui/auth/auth_login.dart';
import 'package:smartcycle/ui/auth/auth_profile.dart';

BuildContext mContext;

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<bool> _isSignIn;

  @override
  void initState() {
    super.initState();
    _isSignIn = AuthUtils().isSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<bool>(
          future: _isSignIn,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("ddd");
          if (!snapshot.data) {
            return LoginPage();
          } else {
            return AuthProfile();
          }
        } else {
          return SCircularProgressWithBtn();
        }
      },
    ));
  } //  @override

  @override
  void dispose() {
    super.dispose();
  }
}
