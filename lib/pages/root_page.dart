import 'package:flutter/material.dart';
import 'package:mayom_app/models/user.dart';
import 'package:mayom_app/pages/home_page.dart';
import 'package:mayom_app/pages/login_page.dart';
import 'package:mayom_app/services/authentication.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_LOGGED_IN;
  User _user = null;
  FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    SharedPreferences.setMockInitialValues({});
    _messaging.getToken().then((token) {
      // print(token);
    });
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _user = user;
        }
        authStatus =
          _user == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _user = user;
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _user = null;
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        return HomePage();
        break;
      default:
        return _buildWaitingScreen();
    }
  }

}