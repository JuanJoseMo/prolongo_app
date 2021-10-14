import 'package:prolongo_app/src/pages/splashScreen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  //Singleton
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences _prefs;
  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Geters y Seters del color
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? SplashScreen.routeName;
  }

  set ultimaPagina(String valor) {
    _prefs.setString('ultimaPagina', valor);
  }

  get color {
    //Si no existe el color, valor por defecto false
    return _prefs.getBool('color') ?? false;
  }

  set color(bool valor) {
    _prefs.setBool('color', valor);
  }

  //Geters y Seters del nombre
  get nombre {
    //Si no existe el nombre, valor por defecto ''
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String valor) {
    _prefs.setString('nombre', valor);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String valor) {
    _prefs.setString('email', valor);
  }

  get password {
    return _prefs.getString('password') ?? '';
  }

  set password(String valor) {
    _prefs.setString('password', valor);
  }

  get id {
    return _prefs.getInt('id') ?? null;
  }

  set id(int valor) {
    _prefs.setInt('id', valor);
  }

  get current {
    return _prefs.getInt('current') ?? 0;
  }

  set current(int valor) {
    _prefs.setInt('current', valor);
  }

  get exit async {
    _prefs.clear();
  }
}
