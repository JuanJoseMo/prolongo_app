import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = 'splashscreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _cuentaAtras();
    _prefs.ultimaPagina = SplashScreen.routeName;
  }

  _cuentaAtras() async {
    var duracion = Duration(seconds: 2);
    return Timer(duracion, () {
      Navigator.pushReplacementNamed(context, 'login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gradientTransparent = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (_prefs.color) ? Colors.black : Colors.white,
            Colors.transparent,
          ],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/images/logo2.png'),
                    height: 150,
                    width: 150,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      child: Image(
                        image: AssetImage('assets/images/charging.gif'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  'Prolongo',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'v1.0.0',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
