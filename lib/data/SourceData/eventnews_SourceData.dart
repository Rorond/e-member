import 'dart:convert';
import 'dart:io';

import 'package:emembers/data/models/eventnewsModel.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class EventNewsSourceData {
  List<NewsEventModel> eventNewsList = [];

  Future<List<NewsEventModel>?> fetchData() async {
    Uri uri = Uri.parse(Constants.apiContent + "/eventnews?status=Aktif");
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      List dataset = json.decode(response.body);

      for (int i = 0; i < dataset.length; i++) {
        eventNewsList.add(new NewsEventModel.fromJson(dataset[i]));
      }
      return eventNewsList;
    }
    return null;
  }
}
