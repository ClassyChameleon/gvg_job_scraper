import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gvg_job_scraper/classes/job_preset.dart';
import 'package:gvg_job_scraper/util.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

Future<List<JobPreset>> scrapeAlfred(String keyword) async {
  //Response response = await get(Uri.parse('https://userapi.alfred.is/api/v2/jobs?page=1&size=27&search=$keyword&translate=false'));
  //Map data = jsonDecode(response.body);

  String jsonData = await rootBundle.loadString('assets/alfred.json');
  Map data = await json.decode(jsonData);

  mapExtractor(data);

  return [];
}
