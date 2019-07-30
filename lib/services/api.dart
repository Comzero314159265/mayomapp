import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{
    final String _url = 'http://192.168.42.89/api/';

    postData(data, apiUrl) async {
        var fullUrl = _url + apiUrl;
        var token = await _getToken();
        return await http.post(
            fullUrl, 
            body: jsonEncode(data), 
            headers: token == null ? _setHeaders() : _setHeadersWithAuth(token)
        );
    }

    getData(apiUrl) async {
      var fullUrl = _url + apiUrl;
      var token = await _getToken();
      return await http.get(
        fullUrl, 
        headers: token == null ? _setHeaders() : _setHeadersWithAuth(token)
      );
    }

    _setHeaders() => {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
    };

    _setHeadersWithAuth(token) => {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization': token.toString()
    };

    _getToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('token');
        return token;
    }
}