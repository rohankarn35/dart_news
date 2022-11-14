import 'package:dart_news/TabBar/entairtnment.dart';
import 'package:dart_news/TabBar/finance.dart';
import 'package:dart_news/TabBar/health.dart';
import 'package:dart_news/TabBar/india.dart';
import 'package:dart_news/TabBar/sports.dart';
import 'package:dart_news/TabBar/top_news.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: GradientText(
              "Dart News",
              textAlign: TextAlign.justify,
              gradientType: GradientType.linear,
              colors: [Colors.red, Colors.blue, Colors.deepPurple],
              textScaleFactor: 1.3,
            ),
            bottom: TabBar(
                dragStartBehavior: DragStartBehavior.start,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "Top News",
                  ),
                  Tab(
                    text: "India",
                  ),
                  Tab(
                    text: "Sports",
                  ),
                  Tab(
                    text: "Health",
                  ),
                  Tab(
                    text: "Entertainmnet",
                  ),
                  Tab(
                    text: "Finance",
                  ),
                ]),
            centerTitle: true,
            backgroundColor: Colors.black87,
            leadingWidth: 3.4,
            elevation: 0,
          ),
          backgroundColor: Color.fromARGB(115, 11, 11, 11),
          body: TabBarView(children: [
            TopNews(),
            india(),
            Sports(),
            health(),
            entairtnment(),
            Finance(),
          ]),
        ),
      ),
    );
  }
}
