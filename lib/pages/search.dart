import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gvg_job_scraper/classes/job_preset.dart';
import 'package:gvg_job_scraper/classes/search_preset.dart';
import 'package:gvg_job_scraper/searches/s_alfred.dart';
import 'package:gvg_job_scraper/searches/s_tvinna.dart';
import 'package:gvg_job_scraper/widgets/app_bar.dart';
import 'package:gvg_job_scraper/widgets/default_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  final SearchPreset searchPreset;
  const Search({super.key, required this.searchPreset});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool useLocalData = false;
  List<JobPreset> foundJobs = [];
  Map<String, int> jobMapper = {};
  String searchText = 'Loading...';
  bool searched = false;
  bool displayLoading = true;
  int selectedIndex = -1;

  void beginSearch() async {
    if (searched) return;
    searched = true;
    if (widget.searchPreset.keywords.isEmpty) {
      searchText = 'Search preset has no search words';
      displayLoading = false;
      setState(() {});
      return;
    }
    for (var i in widget.searchPreset.keywords) {
      print(i);
      searchText = 'Now searching: $i';
      searchKey(i);
      setState(() {});
      await searchKey(i);
    }
    displayLoading = false;
    searchText = 'Finished searching.';
  }

  Future<void> searchKey(String word) async {
    List<Future<List<JobPreset>>> fetchers = [];
    fetchers.add(scrapeAlfred(word.trim().toLowerCase(), useLocalData));
    fetchers.add(scrapeTvinna(word.trim().toLowerCase(), useLocalData));

    for (var i in fetchers) {
      i.whenComplete(() async => addData(await i));
    }

    // Future<List<JobPreset>> a = scrapeAlfred('forrit');
    // Future<List<JobPreset>> t = scrapeTvinna('forrit');
    for (Future<List<JobPreset>> i in fetchers) {
      await i;
    }
    setState(() {});
  }

  void addData(List<JobPreset> jobs) {
    for (JobPreset i in jobs) {
      // Check if company has advertised this job on other sites
      if (jobMapper[i.jobName + i.companyName] != null) {
        int index = jobMapper[i.jobName + i.companyName]!;
        JobPreset dupe = foundJobs.elementAt(index);
        if (dupe.companyName == i.companyName) {
          // If duplicate, add url and check dates
          if (!dupe.urls.contains(i.urls[0])) {
            dupe.urls.addAll(i.urls);
          }
          // print(dupe.urls[0]);
          // print(dupe.urls[1]);
          dupe.deadline ??= i.deadline;
          DateTime nullDestroyer = i.earliestPosting!; // DESTROY POSSIBLE NULL
          if (dupe.earliestPosting!.isAfter(nullDestroyer)) {
            dupe.earliestPosting = nullDestroyer;
          }
        }
      } else {
        jobMapper.addAll({i.jobName + i.companyName: foundJobs.length});
        foundJobs.add(i);
      }
    }
  }

  // Async operations may still be running after unmounting.
  // This prevents errors and memory leaks once they finish and use setState
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (foundJobs.isEmpty) {
      beginSearch();
      return Scaffold(
        appBar: GlobalAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(searchText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  )),
              (() {
                if (displayLoading) return DefaultLoading();
                return Text('No results',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ));
              }())
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: GlobalAppBar(),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                  height: 20,
                  child: Text(searchText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white))),
              Expanded(
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
                                          constraints:
                                              BoxConstraints(maxHeight: 32),
                                          onPressed: (() {
                                            if (selectedIndex == index) {
                                              selectedIndex = -1;
                                            } else {
                                              selectedIndex = index;
                                            }
                                            setState(() {});
                                          }),
                                          icon: (() {
                                            if (index == selectedIndex) {
                                              return Icon(Icons.arrow_drop_up);
                                            } else {
                                              return Icon(
                                                  Icons.arrow_drop_down);
                                            }
                                          }()),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              (() {
                                if (index == selectedIndex) {
                                  print('Index');
                                  return SafeArea(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: foundJobs
                                          .elementAt(index)
                                          .urls
                                          .length,
                                      itemBuilder: (context, urlIndex) {
                                        return RichText(
                                          text: TextSpan(
                                            text: foundJobs
                                                .elementAt(index)
                                                .urls[urlIndex],
                                            style:
                                                TextStyle(color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launchUrl(Uri.parse(foundJobs
                                                    .elementAt(index)
                                                    .urls[urlIndex]));
                                              },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return Container();
                              }())
                            ]),
                      ),
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
}
