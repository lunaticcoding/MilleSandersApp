import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:growthdeck/constants/k_colors.dart';

class MilleSandersWebView extends StatefulWidget {
  MilleSandersWebView(this.url);
  final String url;

  @override
  _MilleSandersWebViewState createState() => _MilleSandersWebViewState();
}

class _MilleSandersWebViewState extends State<MilleSandersWebView> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WebView(
          initialUrl: widget.url,
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kColors.gold),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
