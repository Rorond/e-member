import 'dart:convert';
import 'dart:io';

import 'package:emembers/constants.dart';
import 'package:emembers/data/models/config_point_model.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:http/http.dart' as http;

class ConfigPointService {
  Future<List<ConfigPointModel>> fetchConfigPoint(ProjectList project) async {
    List<ConfigPointModel> result = [];
    Uri uri = Uri.parse(Constants.apiGateway +
        '/loyalty/ConfigPoints?WhereClause=ProjectID=' +
        project.id.toString() +
        '&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=ProjectID');
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('entity')) {
        List<dynamic> dataset = jsonResponse['entity'];
        result = ConfigPointModel.fromJsonList(dataset);
      }
    }
    return result;
  }
}
