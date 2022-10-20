import 'package:flutter/material.dart';
import 'package:my_project/api_info_page.dart';
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
      child: Text("Latest"),
    ),
    Tab(
      child: Text("Technology"),
    ),
    Tab(
      child: Text("Sport"),
    ),
    Tab(
      child: Text("Science"),
    ),
    Tab(
      child: Text("Health"),
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
            backgroundColor: Colors.black26,
            centerTitle: true,
            title: Text("Bi' News",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
                )),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: TabBar(
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  labelColor: Colors.white,
                  controller: _tabController,
                  tabs: tabList,
                ))),
        drawer: Drawer(
          backgroundColor: Colors.grey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration:
                    BoxDecoration(color: Colors.white),
                child: Text("Bi' News v1.0", style: TextStyle(color: Colors.black))
                    
              ),
              ListTile(
                title: const Text('Contact', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactPage()));
                },
              ),
              ListTile(
                title: const Text('API Info', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApiInfoPage()));
                },
              )
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
                            await launch(articles[index].url!);
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
                          await launch(techNews[index].url!);
                        },
                        child: listWidget(techNews[index]));
                  },
                ))),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                    child: ListView.builder(
                  itemCount: sportNews.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          await launch(sportNews[index].url!);
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
                          await launch(scienceNews[index].url!);
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
                          await launch(healthNews[index].url!);
                        },
                        child: listWidget(healthNews[index]));
                  },
                )))
          ],
        ));
  }
}
