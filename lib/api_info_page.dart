// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiInfoPage extends StatefulWidget {
  const ApiInfoPage({Key? key}) : super(key: key);

  @override
  State<ApiInfoPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ApiInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.black26,
        centerTitle: true,
        title: const Text("API Info",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text("News API",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(height: 36),
              Text("Search worldwide news with code",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center),
              SizedBox(height: 36),
              Text("Locate articles and breaking news headlines from news sources and blogs across the web with our JSON API",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center),
              SizedBox(height: 36),
              RaisedButton(
                color: Colors.blueAccent, // background
                textColor: Colors.white, // foreground
                onPressed: () async {
                  await launch("https://newsapi.org/");
                },
                child: Text('Docs and Development'),
              )
            ],
          )
        ],
      ),
    );
  }
}
