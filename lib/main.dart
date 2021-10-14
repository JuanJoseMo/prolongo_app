import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/pages/cart/carrito.dart';
import 'src/pages/shared_prefs/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = new PreferenciasUsuario();
  await _prefs.initPrefs();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Carrito(),
      child: MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
    ),
  );
  SystemChrome.setPreferredOrientations(
    // Con esto conseguiremos que la aplicación no disponga de rotación.
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}
