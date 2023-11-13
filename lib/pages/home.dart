// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/pages/search.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/button_preset.dart';
import 'package:gvg_job_scraper/pages/presets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SearchPreset> presetList = [
    SearchPreset('Web developer', ['html', 'css', 'javascript'],
        ['alfred.is', 'tvinna.is']),
    SearchPreset('Programmer', ['java', 'php', 'javascript'],
        ['alfred.is', 'tvinna.is']),
    SearchPreset('Database Manager', ['SQL', 'Postgres', 'javascript'],
        ['alfred.is', 'tvinna.is']),
    SearchPreset(
        'Demo for mid-search adds',
        ['Dýralæknir', 'Vestmannaeyjar', 'sálfræðing'],
        ['alfred.is', 'tvinna.is']),
    SearchPreset(
        'Demo for no results',
        ['æææææææææææææææ', 'ðððððððððððð', 'qqqqqqqqqqqqqqq'],
        ['alfred.is', 'tvinna.is']),
  ];
  SearchPreset selectedPreset = SearchPreset('None selected', [], []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 8.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_city,
                  size: 64,
                ),
                Text(
                  'JobScraper',
                ),
                Text(
                  'A skyscraper of jobs await you',
                ),
              ],
            ),
            SizedBox(height: 80.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ButtonPreset(
                      onPressed: chooseSearchPreset,
                      childText: 'Choose search preset',
                    ),
                    Text((() {
                      final selectedPreset = this.selectedPreset;
                      if (selectedPreset != null) {
                        return selectedPreset.name;
                      } else {
                        return 'None selected';
                      }
                    }())),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    ButtonPreset(
                      onPressed: beginSearch,
                      childText: 'Search',
                      textStyle: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {}
  void chooseSearchPreset() async {
    final SearchPreset? search = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Presets(
            searchPresets: presetList,
          ),
        ));
    // final List? presetResult = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Presets(
    //         searchPresets: presetList,
    //       ),
    //     ));
    // final SearchPreset search = presetResult![0];
    // presetList = presetResult[1];
    setState(() {
      if (search != null) {
        selectedPreset = search;
      } else {
        selectedPreset = SearchPreset('None selected', [], []);
      }
    });
  }

  beginSearch() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Search(
                  searchPreset: selectedPreset,
                )));
  }
}
