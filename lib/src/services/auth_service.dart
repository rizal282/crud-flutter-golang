import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owl_test/src/config/base_url.dart';
import 'package:owl_test/src/config/endpoint_url.dart';
import 'package:owl_test/src/models/user_data_model.dart';

class AuthService {
  static Future loginUser(Map<String, dynamic> map) async {
    try {
      final response = await http.post(
          Uri.parse(BaseUrl.baseUrl + EndpointUrl.login),
          body: json.encode(map));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<List<UserDataModel>> getAllUsers() async {
    List<UserDataModel> allUsers = [];

    try {
      final response =
          await http.get(Uri.parse(BaseUrl.baseUrl + EndpointUrl.allUsers));

      final dataUsers = json.decode(response.body);

      for (int i = 0; i < dataUsers.length; i++) {
        allUsers.add(UserDataModel(
            idUser: int.parse(dataUsers[i]["id"]),
            nickname: dataUsers[i]["nickname"]));
      }

      return allUsers;
    } catch (e) {
      return [];
    }
  }
}
