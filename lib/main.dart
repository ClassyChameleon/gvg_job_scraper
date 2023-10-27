// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
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
        appBar: AppBar(
          title: Text('JobScraper by gvg'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black, width: 4.0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Begin Search',
                        style: TextStyle(color: Colors.black, fontSize: 40.0)),
                  ],
                ),
              ),
              SizedBox(
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
                          width: 50,
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
