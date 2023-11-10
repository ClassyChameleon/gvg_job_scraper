// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/job_preset.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/searches/s_alfred.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/default_loading.dart';

class Search extends StatefulWidget {
  SearchPreset? searchPreset;
  Search({super.key, required this.searchPreset});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<JobPreset> foundJobs = [];

  void fetchData() async {
    // We'll need a more robust way to do this when we scrape from more websites
    // 1. Remove duplicates
    //  a. start working on duplicates once any website returns data
    //  b. If duplicate found, add url and compare post time and deadline
    Future<List<JobPreset>> a = scrapeAlfred('forrit');
    foundJobs.addAll(await a);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (foundJobs.isEmpty) {
      fetchData();
      return Scaffold(
        appBar: GlobalAppBar(),
        body: DefaultLoading(),
      );
    }

    return Scaffold(
      appBar: GlobalAppBar(),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        child: SafeArea(
          child: ListView.builder(
            itemCount: foundJobs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(8, 8)),
                          side: BorderSide(color: Colors.black)),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foundJobs.elementAt(index).jobName,
                            style: TextStyle(fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(foundJobs.elementAt(index).companyName,
                                style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    constraints: BoxConstraints(maxHeight: 32),
                                    onPressed: onPressed,
                                    icon: Icon(Icons.arrow_drop_down),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onPressed() {}
}
