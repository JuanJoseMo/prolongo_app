import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static final String routeName = 'webview';
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final _prefs = new PreferenciasUsuario();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = HomePage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://www.prolongo.es/es',
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
