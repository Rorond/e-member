import 'dart:convert';
import 'dart:io';

import '../../constants.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class ProfileSourceData {
  List<User> Profiledata = [];

  Future<Type?> fetchData() async {
    Uri uri = Uri.parse(Constants.apiGateway + "/Guest");
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      List dataset = json.decode(response.body);

      for (int i = 0; i < dataset.length; i++) {
        User.add(new User.fromJson(dataset[i]));
      }
      return User;
    }
    return null;
  }
}
