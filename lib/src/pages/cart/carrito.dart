import 'package:flutter/material.dart';
import 'package:prolongo_app/src/models/ProductosModel.dart';

class Carrito extends ChangeNotifier {
  List<Producto> _cardProductos = new List();
  List<Producto> get carrito => _cardProductos;
  void addProducto(Producto p ){
    _cardProductos.add(p);
    notifyListeners();
  }
}
