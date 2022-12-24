import 'package:flutter/material.dart';
import 'package:my_project/contact_page.dart';
import 'package:my_project/data/news_service.dart';
import 'package:my_project/data/tech_news_service.dart';
import 'package:my_project/models/articles.dart';
import 'package:my_project/shared/list_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/health_news_service.dart';
import 'data/science_news_service.dart';
import 'data/sports_news_service.dart';

// ignore_for_file: prefer_const_constructors

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Anasayfa>
    with SingleTickerProviderStateMixin {
  List<Tab> tabList = [
    Tab(
      child: Text("Latest",
          style: TextStyle(color: Color.fromARGB(255, 255, 19, 3))),
    ),
    Tab(
      child: Text("Technology",
          style: TextStyle(color: Color.fromARGB(255, 1, 100, 180))),
    ),
    Tab(
      child: Text("Sport",
          style: TextStyle(color: Color.fromARGB(255, 205, 124, 1))),
    ),
    Tab(
      child: Text("Science",
          style: TextStyle(color: Color.fromARGB(255, 188, 169, 0))),
    ),
    Tab(
      child: Text("Health",
          style: TextStyle(color: Color.fromARGB(255, 0, 188, 6))),
    ),
  ];

  late TabController _tabController;

  List<Articles> articles = [];
  List<Articles> techNews = [];
  List<Articles> sportNews = [];
  List<Articles> scienceNews = [];
  List<Articles> healthNews = [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });

    TechNewsService.getNews().then((value) {
      setState(() {
        techNews = value!;
      });
    });

    SportNewsService.getNews().then((value) {
      setState(() {
        sportNews = value!;
      });
    });

    ScienceNewsService.getNews().then((value) {
      setState(() {
        scienceNews = value!;
      });
    });

    HealthNewsService.getNews().then((value) {
      setState(() {
        healthNews = value!;
      });
    });

    super.initState();

    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 110.0,
            backgroundColor: Color.fromARGB(171, 204, 215, 215),
            centerTitle: true,
            title: Text("Bi' News",
                style: TextStyle(
                    color: Color.fromARGB(172, 0, 0, 0), fontSize: 32)),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: TabBar(
                  indicatorColor: Color.fromARGB(172, 0, 0, 0),
                  isScrollable: true,
                  labelColor: Colors.white,
                  controller: _tabController,
                  tabs: tabList,
                ))),
        drawer: Drawer(
          backgroundColor: Color.fromARGB(125, 0, 0, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(172, 0, 0, 0)),
                  child: Text("Bi' News v1.0",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 255, 255, 255)))),
              ListTile(
                title: const Text('Contact',
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactPage()));
                },
              ),
            ],
          ),
        ),
        // Tab bar area
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () async {
                            await openBrowserURL(
                                url: articles[index].url!.toString(),
                                inApp: true);
                          },
                          child: listWidget(articles[index]));
                    },
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  child: ListView.builder(
                itemCount: techNews.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () async {
                        await openBrowserURL(
                            url: techNews[index].url.toString(), inApp: true);
                      },
                      child: listWidget(techNews[index]));
                },
              )),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                    child: ListView.builder(
                  itemCount: sportNews.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          await openBrowserURL(
                              url: sportNews[index].url!.toString(),
                              inApp: true);
                          
                        },
                        child: listWidget(sportNews[index]));
                  },
                ))),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                    child: ListView.builder(
                  itemCount: scienceNews.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          await openBrowserURL(
                              url: scienceNews[index].url!.toString(),
                              inApp: true);
                        },
                        child: listWidget(scienceNews[index]));
                  },
                ))),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                    child: ListView.builder(
                  itemCount: healthNews.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          await openBrowserURL(
                              url: healthNews[index].url!.toString(),
                              inApp: true);
                        },
                        child: listWidget(healthNews[index]));
                  },
                )))
          ],
        ));
  }

  Future openBrowserURL({required String url, bool inApp = false}) async {
    // ignore: deprecated_member_use
    await launch(
      url,
      forceWebView: inApp,
      enableJavaScript: true,
    );
  }
}
