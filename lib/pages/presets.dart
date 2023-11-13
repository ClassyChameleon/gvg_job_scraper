import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/pages/preset.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/button_preset.dart';

class Presets extends StatefulWidget {
  List<SearchPreset> searchPresets;
  Presets({super.key, required this.searchPresets});

  @override
  State<Presets> createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
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
                  final newPreset = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Preset(searchPreset: null)));
                  setState(() {
                    widget.searchPresets.add(newPreset);
                  });
                },
                childText: 'Create new preset'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.searchPresets.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  // DELETE PRESET
                  SizedBox(
                    height: 50,
                    width: 32,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.searchPresets.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 64,
                    // EDIT PRESET
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context, widget.searchPresets[index]);
                      },
                      title: Text(
                        widget.searchPresets.elementAt(index).name,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 32,
                    child: IconButton(
                        onPressed: () async {
                          final newPreset = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Preset(
                                      searchPreset:
                                          widget.searchPresets[index])));
                          setState(() {
                            widget.searchPresets[index] = newPreset;
                          });
                        },
                        icon: Icon(Icons.edit)),
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
