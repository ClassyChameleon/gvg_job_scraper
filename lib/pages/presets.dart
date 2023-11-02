import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/pages/preset.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/button_preset.dart';

class Presets extends StatefulWidget {
  const Presets({super.key});

  @override
  State<Presets> createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  List<SearchPreset> searchPresets = [
    SearchPreset('Web developer', ['html', 'css', 'javascript'],
        ['alfred.is', 'jobs.com']),
    SearchPreset(
        'Programmer', ['java', 'php', 'javascript'], ['alfred.is', 'jobs.com']),
    SearchPreset('Database Manager', ['SQL', 'Postgres', 'javascript'],
        ['alfred.is', 'jobs.com']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonPreset(
                onPressed: () async {
                  final newPreset = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Preset()));
                  setState(() {
                    searchPresets.add(newPreset);
                  });
                },
                childText: 'Create new preset'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: searchPresets.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 32,
                    child: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 320,
                    child: ListTile(
                      title: Text(
                        searchPresets.elementAt(index).name,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 32,
                    child: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
