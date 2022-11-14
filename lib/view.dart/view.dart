import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class view extends StatefulWidget {
  String url;
  view(this.url);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  late String finalUrl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  void initState() {
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Web View"),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: (() {}),
              child: Icon(Icons.share),
            ),
          ),
        ],
      ),
      body: Container(
        child: WebView(
            initialUrl: finalUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              setState(() {
                controller.complete(webViewController);
              });
            }),
      ),
    );
  }
}
