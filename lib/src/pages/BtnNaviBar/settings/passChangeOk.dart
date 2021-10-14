import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';

class PassChangeOk extends StatefulWidget {
  static final String routeName = 'passChangeOk';
  @override
  _PassChangeOkState createState() => _PassChangeOkState();
}

class _PassChangeOkState extends State<PassChangeOk> {
  final _prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _cuentaAtras();
    _prefs.ultimaPagina = HomePage.routeName;
  }

  _cuentaAtras() async {
    var duracion = Duration(seconds: 2);
    return Timer(duracion, () {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              color: (_prefs.color) ? Colors.black : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Image(
                    image: AssetImage('assets/images/checkPass.gif'),
                    height: 150,
                    width: 150,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
