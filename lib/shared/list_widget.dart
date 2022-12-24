import 'package:flutter/material.dart';
import '../models/articles.dart';

Widget listWidget(Articles articles) {
  var publishedDate = articles.publishedAt.toString();
  var spliceDate = publishedDate.substring(0, 10);

  // var authorName = articles.author;
  // if(authorName.startsWith("http"));

  // var authorName = articles.author.toString();
  // var spliceAuthor = authorName.substring(0,12);

  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20.0),
    child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(articles.urlToImage ??
                      "https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif?20151024034921"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articles.title!,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    Text(
                      spliceDate,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    
                  ],
                )
              ],
            ))
          ],
        )),
  );
}
