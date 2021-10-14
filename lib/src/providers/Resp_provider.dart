import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prolongo_app/src/models/ProductosModel.dart';
import 'package:prolongo_app/src/models/UsuariosModel.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';

class ProductosProvider {
  String urlInstituto = "---";

  int productosPage = 0;

  List<Producto> productos = new List();
  List<Producto> cardProductos = new List();
  final _productosStream = StreamController<List<Producto>>.broadcast();
  final _cardProductosStream = StreamController<List<Producto>>.broadcast();

  //Introducir datos al stream
  Function(List<Producto>) get productosSink => _productosStream.sink.add;
  Function(List<Producto>) get cardProductosSink => _cardProductosStream.sink.add;
  
  void sinkProducto(Producto p) {
    print('${p.nombre}');
    cardProductos.add(p);
    print('${cardProductos.indexOf(p)}');
    _cardProductosStream.sink.add(cardProductos);
    cardProductosStream.listen((event) {
      print(event);
    });
  }

  //Escuchar datos del stream
  Stream<List<Producto>> get productosStream => _productosStream.stream;
  Stream<List<Producto>> get cardProductosStream => _cardProductosStream.stream;

  //Liberar el stream
  void disposeStream() {
    _productosStream?.close();
    _cardProductosStream?.close();
  }

  void getProductos() async {
    productosPage++;
    final url = Uri.https(urlInstituto,
        "practicajuanjo/index.php/productos/pagsproductos/$productosPage");
    String _key = "---";

    final resp = await http.get(url, headers: {"x-api-key": _key});
    final decodedData = json.decode(resp.body);
    final respuesta = new Productos.fromJson(decodedData);
    if (productosPage <= respuesta.totalPag) {
      productos.addAll(respuesta.productos);
      print(productos);
      productosSink(productos);
    }
  }

  Future<List<Producto>> buscarProducto(String query) async {
    //Contruimos la peticuión a la API
    final urlInstituto = Uri.https('---',
        '/practicajuanjo/index.php/productos/search/$query');
    String _key = "---";
    print('La url de busqueda es: $urlInstituto');
    final resp = await http.get(urlInstituto, headers: {"x-api-key": _key});
    final decodedData = json.decode(resp.body);
    final productos = new Productos.fromJson(decodedData);
    return productos.productos;
  }
}

class UsuariosProvider {
  Future<dynamic> registro(String nombre, String email, String password) async {
    //Set up PUT request arguments
    String urlInstituto =
        "https://---/practicajuanjo/index.php/users/registro";
    Map<String, String> datos = {
      'nombre': '$nombre',
      'email': '$email',
      'password': '$password'
    };
    String _key = "---";

    //Make PUT request
    http.Response response =
        await http.put(urlInstituto, body: datos, headers: {"x-api-key": _key});

    //Check the status code for the result
    int statusCode = response.statusCode;
    print(
        "El estado es: $statusCode \nNombre: $nombre, email: $email, password: $password");
    if (statusCode == 200) {
      String body = response.body;
      print(body);
      final decodedData = json.decode(response.body);
      final usuario = new Usuarios.fromJson(decodedData);
      return usuario;
    } else {
      return null;
    }
  }

  Future<dynamic> login(String email, String password) async {
    //Set up PUT request arguments
    String urlInstituto =
        "https://---/practicajuanjo/index.php/users/login";
    Map<String, String> datos = {'email': '$email', 'password': '$password'};
    String _key = "---";

    //Make PUT request
    http.Response response =
        await http.put(urlInstituto, body: datos, headers: {"x-api-key": _key});

    //Check the status code for the result
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      String body = response.body;
      print('El status es:$statusCode\nEl body es: $body');
      final decodedData = json.decode(response.body);
      final respLogin = new Usuarios.fromJson(decodedData);
      return respLogin.usuario[0];
    } else {
      return null;
    }
  }

  Future<dynamic> update(int id, String nombre, String password) async {
    //Set up Post request arguments
    String urlInstituto =
        "https://---/practicajuanjo/index.php/users/edituser";
    String _key = "---";
    Map<String, dynamic> datos = {
      'id': '${id}',
      'nombre': '${nombre}',
      'password': '${password}'
    };

    //Make Post request
    http.Response response = await http.post(
      urlInstituto,
      body: datos,
      headers: {"x-api-key": _key},
    );

    //Check the status code for the result
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      //This API passes back the updated item with the id added
      String body = response.body;
      print(body);
      int statusCode = response.statusCode;
      print("El estado es: $statusCode");
      final decodedData = json.decode(response.body);
      final usuario = new Usuario.fromJson(decodedData);
      return usuario;
    } else {
      return null;
    }
  }

  void delete(PreferenciasUsuario prefs) async {
    //Set up Post request arguments
    String urlInstituto =
        "https://---/practicajuanjo/index.php/users/delete";
    String _key = "---";
    Map<String, dynamic> json = {
      'id': '${prefs.id}',
      'email': '${prefs.email}',
    };

    //Make Post request
    http.Response response = await http.post(
      urlInstituto,
      body: json,
      headers: {"x-api-key": _key},
    );

    //This API passes back the updated item with the id added
    String body = response.body;
    print(body);
    int statusCode = response.statusCode;
    print("El estado es: $statusCode");
  }
}
