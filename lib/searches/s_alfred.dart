import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gvg_job_scraper/classes/job_preset.dart';
import 'package:gvg_job_scraper/util.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

Future<List<JobPreset>> scrapeAlfred(String keyword, bool useLocalData) async {
  List<JobPreset> results = [];
  Map data;
  if (useLocalData) {
    String jsonData = await rootBundle.loadString('assets/alfred.json');
    data = await json.decode(jsonData);
  } else {
    Response response = await get(Uri.parse(
        'https://userapi.alfred.is/api/v2/jobs?page=1&size=27&search=$keyword&translate=false'));
    data = jsonDecode(response.body);
  }

  //mapIterator(data);
  for (var i in data['jobs']) {
    String slug = i['slug'];
    results.add(JobPreset(
        i['brand']['name'],
        i['title'],
        ["https://www.alfred.is/starf/$slug"],
        DateTime.parse(i['created']),
        i['deadline'] == null ? null : DateTime.parse(i['deadline'])));
    //print(i['title']);
    //print("alfred.is/starf/$slug");
    //print(i['brand']['name']);
  }

  //print(data['jobs'][0]['deadline']);

  return results;
}
