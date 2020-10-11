import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/Models/newsInfo.dart';

import 'constants/constants.dart';

class ApiManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel = null;
    try {
      var response = await client.get("$url");
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
