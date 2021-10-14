import 'package:flutter/material.dart';
import 'pages/Bloc/provider.dart';
import 'package:prolongo_app/src/pages/BtnNaviBar/maps.dart';
import 'pages/BtnNaviBar/settings/changePass.dart';
import 'package:prolongo_app/src/pages/BtnNaviBar/settings/passChangeOk.dart';
import 'package:prolongo_app/src/pages/BtnNaviBar/settings/settings.dart';
import 'package:prolongo_app/src/pages/BtnNaviBar/settings/webviewPage.dart';
import 'package:prolongo_app/src/pages/BtnNaviBar/shop.dart';
import 'pages/cart/cart.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'pages/login/login_page.dart';
import 'package:prolongo_app/src/pages/productDetail/productDetail.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';
import 'package:prolongo_app/src/pages/signUp/signUpPage.dart';
import 'pages/splashScreen/splashScreen.dart';

class MyApp extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Prolongo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
          primaryColor: Colors.red,
          fontFamily: 'Raleway',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //Inicializamos la primera página que nuestra app va a mostrar a la ultima página guardada en el preferences.
        //En caso de no existir ninguna mostrará nuestro splashscreen.
        initialRoute: _prefs.ultimaPagina,
        routes: {
          SplashScreen.routeName: (BuildContext context) => SplashScreen(),
          LoginPageV2.routeName: (BuildContext context) => LoginPageV2(),
          SignUpPage.routeName: (BuildContext context) => SignUpPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          ShopPage.routeName: (BuildContext context) => ShopPage(),
          CartPage.routeName: (BuildContext context) => CartPage(),
          ProductoDetalle.routeName: (BuildContext context) =>
              ProductoDetalle(),
          //'search': (BuildContext context) => ProductosSearch().buildSuggestions(context),
          MapsPage.routeName: (BuildContext context) => MapsPage(),
          WebViewPage.routeName: (BuildContext context) => WebViewPage(),
          SettingsPage.routeName: (BuildContext context) => SettingsPage(),
          PassChangeOk.routeName: (BuildContext context) => PassChangeOk(),
          ChangePass.routeName: (BuildContext context) => ChangePass(),
        },
      ),
    );
  }
}
