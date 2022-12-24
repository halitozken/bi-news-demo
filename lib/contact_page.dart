import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ContactPage> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Color.fromARGB(171, 204, 215, 215),
          centerTitle: true,
          title: const Text("Contact",
              style: TextStyle(
                color: Color.fromARGB(172, 0, 0, 0),
              )),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            buildContent(),
            buildText()
          ],
        ));
  }

  Widget buildText() => Column(
        children: const [
          Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "halitozken@gmail.com",
                style: TextStyle(fontSize: 22),
              ))
        ],
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 38),
          const Text(
            'Halit Ozken',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Developer',
              style: TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(
                  FontAwesomeIcons.github, "https://github.com/halitozken"),
              const SizedBox(width: 12),
              buildSocialIcon(
                  FontAwesomeIcons.twitter, "https://twitter.com/halitozken"),
              const SizedBox(width: 12),
              buildSocialIcon(FontAwesomeIcons.linkedin,
                  "https://www.linkedin.com/in/halitozken/"),
              const SizedBox(width: 12),
            ],
          ),
        ],
      );

  Widget buildSocialIcon(IconData icon, String goLink) => CircleAvatar(
        radius: 40,
        child: Material(
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
                onTap: () async {
                  await launch(goLink);
                },
                child: Center(child: Icon(icon, size: 42)))),
      );

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverImage()),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ]);
  }

  Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.network(
        'https://i.pinimg.com/originals/40/bf/50/40bf5022f099e7030c11e17e50f4b3da.png',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ));

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/78592080?v=4'),
      );
}
