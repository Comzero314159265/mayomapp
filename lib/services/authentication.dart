import 'dart:async';

import 'dart:convert';

import 'package:mayom_app/models/user.dart';
import 'package:mayom_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  Future<String> signIn(String email, String password) async {
    var data = {
        'email' : email, 
        'password' : password
    };
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["token_type"] + " " + body["access_token"];
    }
    return "";
  }

  Future<String> signUp(String email, String password) async {
    // FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
    //     email: email, password: password);
    // return user.uid;
  }

  Future<User> getCurrentUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString("token");
    var res = await CallApi().getData('user');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      User user = User.fromJson(body);
      return user;
    }
    return null;

  }

  Future<void> signOut() async {
    // return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    // FirebaseUser user = await _firebaseAuth.currentUser();
    // user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    // FirebaseUser user = await _firebaseAuth.currentUser();
    // return user.isEmailVerified;
  }

}