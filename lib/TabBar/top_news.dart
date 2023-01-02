import 'dart:convert';

import 'package:dart_news/model.dart';
import 'package:dart_news/view.dart/view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class TopNews extends StatefulWidget {
  const TopNews({super.key});

  @override
  State<TopNews> createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> with AutomaticKeepAliveClientMixin {
  List<NewsModel> Newslist = <NewsModel>[];

  var cdate = DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(Duration(days: 30)));

  bool isloading = true;
  getnews() async {
    Map element;
    int i = 0;
    String url =
        "https://newsapi.org/v2/everything?q=breaking&from=$cdate&sortBy=publishedAt&apiKey=0a7e9229bfdc4858857e13edb6350189";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(cdate);
    setState(() {
      for (element in data["articles"]) {
        NewsModel newsModel = new NewsModel();
        newsModel = NewsModel.fromMap(element);
        Newslist.add(newsModel);
        setState(() {
          isloading = false;
        });
      }
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
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 10.0,
                                shadowColor: Color.fromARGB(255, 44, 243, 173),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => view(
                                                    Newslist[index].newsUrl))));
                                      },
                                      onLongPress: () {
                                        Share.share(Newslist[index].newsUrl);
                                      },
                                      child: Image.network(
                                        Newslist[index].newsImg,
                                        fit: BoxFit.fitHeight,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Container(
                                        child: IconButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 350, vertical: 8),
                                      icon: Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},

                                      // Icons.favorite,
                                      // color: Colors.white,
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
                                                  Colors.black12.withOpacity(0),
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
                                                        20
                                                    ? "${Newslist[index].newsHead.substring(0, 20)}..."
                                                    : Newslist[index].newsHead,
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
                                                          80
                                                      ? "${Newslist[index].newsDes.substring(0, 80)}..."
                                                      : Newslist[index].newsDes,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ))
                                  ],
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
