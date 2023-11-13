import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';

class SearchWords extends StatefulWidget {
  const SearchWords({super.key});

  @override
  State<SearchWords> createState() => _SearchWordsState();
}

class _SearchWordsState extends State<SearchWords> {
  Set<String> keywords = {'1', '2', '3', '4', '5'};
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GlobalAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.green),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side:
                            const BorderSide(color: Colors.black, width: 4.0)),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Begin Search',
                        style: TextStyle(color: Colors.black, fontSize: 40.0)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                        controller: textController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter new keyword...',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: addKeyword,
                          icon: const Icon(Icons.add),
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
                          width: 50,
                          child: IconButton(
                            onPressed: () {
                              keywords.remove(keywords
                                  .elementAt(keywords.length - index - 1));
                              setState(() {});
                            },
                            icon: const Icon(Icons.close),
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
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addKeyword() {
    keywords.add(textController.text);
    textController.clear();
    setState(() {});
  }

  void onPressed() {}
}
