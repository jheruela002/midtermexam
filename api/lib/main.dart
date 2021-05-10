import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePages(),
      debugShowCheckedModeBanner: false,
    ));

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  String movie;
  List listmovie;
  Map mapmovie;
  List listofmovie;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('https://www.episodate.com/api/most-popular?page=1'));
    if (response.statusCode == 200) {
      setState(() {
        mapmovie = json.decode(response.body);
        listofmovie = mapmovie['tv_shows'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie"),
          backgroundColor: Colors.orange.withAlpha(100),
        ),
        body: mapmovie == null
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
                    ),
                    Text(
                      "THE TOP 20 MOVIE'S",
                      style:
                          TextStyle(fontSize: 30, fontStyle: FontStyle.normal),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            shadowColor: Colors.orange[900],
                            elevation: 10,
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 100,
                                        top: 120,
                                        left: 10,
                                      ),
                                    ),
                                    Image.network(
                                      listofmovie[index]
                                          ['image_thumbnail_path'],
                                      width: 120,
                                      height: 180,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              listofmovie[index]['name']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Status:",
                                              style: TextStyle(fontSize: 15),
                                              textAlign: TextAlign.right,
                                            ),
                                            Text(
                                              listofmovie[index]['status']
                                                  .toString(),
                                              style: TextStyle(fontSize: 15),
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Date:",
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.right),
                                            Text(
                                                listofmovie[index]['start_date']
                                                    .toString(),
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.right),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Country:",
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.right),
                                            Text(
                                                listofmovie[index]['country']
                                                    .toString(),
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.right),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Network:",
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.right),
                                            Text(
                                                listofmovie[index]['network']
                                                    .toString(),
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.right),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: listofmovie == null ? 0 : listofmovie.length,
                    )
                  ],
                ),
              ));
  }
}
