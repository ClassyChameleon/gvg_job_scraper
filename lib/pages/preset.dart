// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/button_preset.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class Preset extends StatefulWidget {
  const Preset({super.key});

  @override
  State<Preset> createState() => _PresetState();
}

class _PresetState extends State<Preset> {
  Set<String> keywords = {'1', '2', '3', '4', '5'};
  List<ValueItem> websites = <ValueItem>[
    ValueItem(label: 'alfred.is'),
  ];
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
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Search from all available websites'),
                Checkbox(
                    value: selectAllWebsites,
                    onChanged: ((bool) {
                      selectAllWebsites = bool!;
                      setState(() {});
                    })),
              ],
            ),
            // Show dropdown only if not selecting all websites
            if (!selectAllWebsites)
              MultiSelectDropDown(
                hint: 'Select websites to search from',
                onOptionSelected: (List<ValueItem> selectedOptions) {},
                options: websites,
                selectedOptions: websites,
              ),
            SizedBox(
              height: 60.0,
              width: 500.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                      SizedBox(
                        height: 50,
                        width: 320,
                        child: ListTile(
                          title: Text(
                            keywords.elementAt(keywords.length - index - 1),
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
                            keywordEditTextController.text =
                                keywords.elementAt(keywords.length - index - 1);
                            await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                title: Text('Edit search word'),
                                children: [
                                  TextField(
                                      autofocus: true,
                                      controller: keywordEditTextController)
                                ],
                              ),
                            );
                            keywords.remove(keywords
                                .elementAt(keywords.length - index - 1));
                            keywords.add(keywordEditTextController.text);
                            setState(() {});
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonPreset(
                  onPressed: onPressed, childText: 'Create Preset'),
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
}
