import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gvg_job_scraper/classes/job_preset.dart';
import 'package:gvg_job_scraper/util.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

Future<List<JobPreset>> scrapeTvinna(String keyword) async {
  List<JobPreset> results = [];
  // Response response = await get(Uri.parse('https://www.tvinna.is/wp-json/'));
  // Response response = await get(Uri.parse('https://www.tvinna.is/wp-json/wp/v2'));

  // Fetch from website
  // Response response = await get(Uri.parse('https://www.tvinna.is/?s=$keyword'));
  // String result = response.body;

  String result = await rootBundle.loadString('assets/tvinna.txt');

  // print('=========================================');
  // print('                PRINT');
  // print('=========================================');
  result = result.substring(result.indexOf('job-listing'));
  result = result.substring(0, result.indexOf('</ul>'));
  // print(result);
  List<String> sectioned = result.split('</li>');
  sectioned.removeLast();

  for (var i in sectioned) {
    // Extract URL
    // print('=========================================');
    // print('                NEW ELEMENT');
    // print('=========================================');
    String url = i.substring(i.indexOf('<a href=') + 9);
    // print(url);
    url = url.substring(0, url.indexOf('">'));
    // Extract date (transform to correct format)
    String date =
        i.substring(i.indexOf('<strong>') + 8, i.indexOf('</strong>'));
    List<String> dateL = date.split('.');
    if (dateL[0].length == 1) dateL[0] = '0${dateL[0]}';
    if (dateL[1].length == 1) dateL[0] = '0${dateL[1]}';
    date = '20${dateL[2]}-${dateL[1]}-${dateL[0]}';

    results.add(
      JobPreset(
          i.substring(i.indexOf('<p>') + 3, i.indexOf(' <span')),
          i.substring(i.indexOf('<h2>') + 4, i.indexOf('</h2>')),
          [url],
          DateTime.parse(date),
          null),
    );
  }

  // print('=========================================');
  // print('                SHOW WORK');
  // print('=========================================');

  // print(results[0].companyName);
  // print(results[0].jobName);
  // print(results[0].urls[0]);
  // print(results[0].earliestPosting);
  // print(results[0].deadline);

  return results;
}