import 'dart:convert';

import 'package:dart_news/model.dart';
import 'package:dart_news/view.dart/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Sports extends StatefulWidget {
  const Sports({super.key});

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> with AutomaticKeepAliveClientMixin {
  List<NewsModel> Newslist = <NewsModel>[];

  var cdate = DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(Duration(days: 30)));

  bool isloading = true;
  getnews() async {
    String url =
        "https://newsapi.org/v2/everything?q=sport&from=$cdate&sortBy=publishedAt&apiKey=0a7e9229bfdc4858857e13edb6350189";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(cdate);
    setState(() {
      data["articles"].forEach((element) {
        NewsModel newsModel = new NewsModel();
        newsModel = NewsModel.fromMap(element);
        Newslist.add(newsModel);
        setState(() {
          isloading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getnews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: !isloading
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: Newslist.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              view(Newslist[index].newsUrl)));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  elevation: 3.0,
                                  shadowColor: Colors.grey,
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        Newslist[index].newsImg,
                                        fit: BoxFit.fitHeight,
                                        width: double.infinity,
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 315, vertical: 10),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          )),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 350, vertical: 10),
                                          child: Icon(
                                            Icons.share,
                                            color: Colors.white,
                                          )),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12
                                                        .withOpacity(0),
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                )),
                                            padding: EdgeInsets.fromLTRB(
                                                20, 15, 17, 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Newslist[index]
                                                              .newsHead
                                                              .length >
                                                          40
                                                      ? "${Newslist[index].newsHead.substring(0, 40)}..."
                                                      : Newslist[index]
                                                          .newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                    Newslist[index]
                                                                .newsDes
                                                                .length >
                                                            50
                                                        ? "${Newslist[index].newsDes.substring(0, 50)}..."
                                                        : Newslist[index]
                                                            .newsDes,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12))
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(180),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
