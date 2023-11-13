// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/button_preset.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class Preset extends StatefulWidget {
  SearchPreset? searchPreset;
  Preset({super.key, required this.searchPreset});

  @override
  State<Preset> createState() => _PresetState();
}

class _PresetState extends State<Preset> {
  Set<String> keywords = {};
  List<ValueItem> websites = <ValueItem>[
    ValueItem(label: 'alfred.is'),
    ValueItem(label: 'tvinna.is'),
  ];
  List<ValueItem> selectedWebsites = [];
  final titleTextController = TextEditingController();
  final keywordTextController = TextEditingController();
  final keywordEditTextController = TextEditingController();
  final MultiSelectController _controller = MultiSelectController();
  bool selectAllWebsites = true;

  @override
  void dispose() {
    keywordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchPreset != null) {
      titleTextController.text = widget.searchPreset!.name;
      for (String i in widget.searchPreset!.keywords) {
        keywords.add(i);
      }
      for (String i in widget.searchPreset!.websites) {
        selectedWebsites.add(
          ValueItem(label: i),
        );
      }
      widget.searchPreset = null;
      if (selectedWebsites.length != websites.length) {
        selectAllWebsites = false;
      }
    }
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Preset name',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Search from all available websites'),
                Checkbox(
                    value: selectAllWebsites,
                    onChanged: ((booly) {
                      selectAllWebsites = booly!;
                      setState(() {
                        if (!selectAllWebsites) {
                          selectedWebsites.clear();
                          for (ValueItem i in websites) {
                            selectedWebsites.add(i);
                          }
                        }
                      });
                    })),
              ],
            ),
            // WEBSITE DROPDOWN
            if (!selectAllWebsites)
              MultiSelectDropDown(
                hint: 'Select websites to search from',
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  selectedWebsites = selectedOptions;
                },
                options: websites,
                selectedOptions: selectedWebsites,
              ),
            SizedBox(
              height: 60.0,
              width: 500.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    // ENTER NEW KEYWORD
                    child: TextField(
                      controller: keywordTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter new keyword...',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: addKeyword,
                        icon: Icon(Icons.add),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: keywords.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // REMOVE KEYWORD
                      SizedBox(
                        height: 50,
                        width: 32,
                        child: IconButton(
                          onPressed: () {
                            keywords.remove(keywords
                                .elementAt(keywords.length - index - 1));
                            setState(() {});
                          },
                          icon: Icon(Icons.close),
                        ),
                      ),
                      // EDIT KEYWORD
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 64,
                        child: ListTile(
                          onTap: () async {
                            keywordEditTextController.text =
                                keywords.elementAt(keywords.length - index - 1);
                            await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                title: Text('Edit search word'),
                                children: [
                                  TextField(
                                      textAlign: TextAlign.center,
                                      autofocus: true,
                                      controller: keywordEditTextController)
                                ],
                              ),
                            );
                            setState(() {
                              int len = keywords.length;
                              Set<String> tKeywords = {};
                              for (int i = 0; i < len; i++) {
                                if (i == len - index - 1) {
                                  tKeywords.add(keywordEditTextController.text);
                                } else {
                                  tKeywords.add(keywords.elementAt(i));
                                }
                              }
                              keywords = tKeywords;
                            });
                          },
                          title: Text(
                            keywords.elementAt(keywords.length - index - 1),
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonPreset(onPressed: createPreset, childText: 'Finish'),
            )
          ],
        ),
      ),
    );
  }

  addKeyword() {
    keywords.add(keywordTextController.text);
    keywordTextController.clear();
    setState(() {});
  }

  void onPressed() {}

  void createPreset() {
    List<String> webs = [];
    for (int i = 0; i < selectedWebsites.length; i++) {
      webs.add(selectedWebsites[i].label);
    }
    SearchPreset newPreset =
        SearchPreset(titleTextController.text, keywords.toList(), webs);
    print(selectedWebsites.toString());
    Navigator.pop(context, newPreset);
  }
}
