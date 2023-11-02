// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';

class Search extends StatefulWidget {
  SearchPreset? searchPreset;
  Search({super.key, required this.searchPreset});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
