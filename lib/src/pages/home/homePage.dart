import 'package:flutter/material.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';
import '../BtnNaviBar/maps.dart';
import '../BtnNaviBar/settings/settings.dart';
import '../BtnNaviBar/shop.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _prefs = new PreferenciasUsuario();
  //int _currentIndex = 0;
  //Lista con las diferentes páginas de nuestra app
  List<Widget> _children = [
    //Páginas
    ShopPage(),
    MapsPage(),
    SettingsPage(),
  ];
  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = HomePage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: _children[_currentIndex],
      body: _children[_prefs.current],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.red,
        ),
        child: new BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                label: 'Tienda'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.near_me,
                ),
                label: 'Localización'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Ajustes'),
          ],
          //currentIndex: _currentIndex,
          currentIndex: _prefs.current,
          onTap: (pos) {
            //_currentIndex = pos;
            _prefs.current = pos;
            setState(() {});
          },
        ),
      ),
    );
  }
}
