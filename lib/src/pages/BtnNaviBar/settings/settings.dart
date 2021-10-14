import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:prolongo_app/src/pages/Bloc/provider.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';

import 'package:prolongo_app/src/providers/Resp_provider.dart';
import 'package:prolongo_app/src/widgets/myBehavior.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  WebViewController _controller;
  bool _colorSecundario;
  final _prefs = new PreferenciasUsuario();
  UsuariosProvider usuarioProvi = new UsuariosProvider();
  @override
  void initState() {
    super.initState();
    _colorSecundario = _prefs.color;
    _prefs.ultimaPagina = HomePage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      backgroundColor: (_prefs.color) ? Colors.black : Colors.white,
      body: Stack(children: [
        _crearFondo(context),
        ScrollConfiguration(
          //Quitaremos el sombreado del scroll con nuestro MyBehavior().
          behavior: MyBehavior(),
          child: ListView(
            children: [
              //CUENTA PERSONAL
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text('Cuenta Personal',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              Container(
                child: Image(
                  image: AssetImage('assets/images/userPhoto.png'),
                  width: 125,
                  height: 125,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                //Mostraremos el nombre que está guardado en el preferences
                child: Text(
                  'Nombre: ${_prefs.nombre}',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: (_prefs.color) ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                //Mostraremos el correo que está guardado en el preferences
                child: Text(
                  'Correo electrónico: ${_prefs.email}',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: (_prefs.color) ? Colors.white : Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Contraseña \n(Pulsa para cambiar tu contraseña)',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: (_prefs.color) ? Colors.white : Colors.black),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, 'changePass'),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                    color: (_prefs.color) ? Colors.white : Colors.red,
                    child: Text(
                      'Eliminar la cuenta',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: (_prefs.color) ? Colors.black : Colors.white),
                    ),
                    onPressed: () {
                      //Una vez que pulsemos borraremos del preferences los datos y eliminemos la cuenta y el usuario volverá a la pantalla de login.
                      _delete();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                    color: (_prefs.color) ? Colors.white : Colors.red,
                    child: Text(
                      'Cerrar sesión',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: (_prefs.color) ? Colors.black : Colors.white),
                    ),
                    onPressed: () {
                      //Una vez que pulsemos borraremos del preferences los datos y el usuario volverá a la pantalla de login.
                      _prefs.exit;
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //AJUSTES
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Ajustes',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: (_prefs.color) ? Colors.white : Colors.black),
                ),
              ),
              SwitchListTile(
                activeColor: Colors.red,
                value: _colorSecundario,
                onChanged: _setColor,
                //Pulsado sobre este switch vamos a cambiar de fondo varias pantallas de la aplicación
                title: Text(
                  'Tema oscuro',
                  style: TextStyle(
                      color: (_prefs.color) ? Colors.white : Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Más sobre nosotros',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: (_prefs.color) ? Colors.white : Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'webview');
                },
                child: SizedBox(
                  height: 200.0,
                  width: 350.0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Carousel(
                      images: [
                        AssetImage('assets/images/descProlongo.png'),
                        AssetImage('assets/images/descProlongo1.png'),
                        AssetImage('assets/images/descProlongo2.png'),
                        AssetImage('assets/images/descProlongo3.png'),
                      ],
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.transparent.withOpacity(0.0),
                      borderRadius: true,
                      moveIndicatorFromBottom: 180.0,
                      noRadiusForIndicator: true,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Image.asset(
                    'assets/images/settings.png',
                    height: 50,
                    width: 50,
                    color: Color(0xFF777777),
                  ),
                  Text(
                    'Versión: 1.0.0',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                  Text(
                    'App creada con Flutter',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    final size = MediaQuery.of(context).size;
    final imagenFondo = Container(
        height: size.height * 0.4,
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/fondo3.jpg'),
          fit: BoxFit.fill,
        ));
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
    return Stack(
      children: [
        imagenFondo,
        gradientTransparent,
      ],
    );
  }

  _setColor(bool valor) async {
    _prefs.color = valor;
    setState(() {
      _colorSecundario = valor;
    });
  }

  _delete() {
    final UsuariosProvider u = new UsuariosProvider();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        elevation: 8.0,
        title: Text('¿Desea eliminar la cuenta?'),
        actions: [
          FlatButton(
            onPressed: () {
              u.delete(_prefs);
              print('Se va a eliminar el usuario.');
              _prefs.exit;
              Navigator.pushReplacementNamed(context, 'login');
            },
            child: Text(
              'Aceptar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Volver',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
