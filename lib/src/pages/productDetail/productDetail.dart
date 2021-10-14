import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prolongo_app/src/models/ProductosModel.dart';
import 'package:prolongo_app/src/pages/cart/carrito.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/providers/Resp_provider.dart';

import '../shared_prefs/preferencias_usuario.dart';

class ProductoDetalle extends StatefulWidget {
  static final String routeName = 'productDetail';
  final Producto p;

  const ProductoDetalle({Key key, this.p}) : super(key: key);

  @override
  _ProductoDetalleState createState() => _ProductoDetalleState();
}

class _ProductoDetalleState extends State<ProductoDetalle> {
  final _prefs = new PreferenciasUsuario();
  final cardProducto = new ProductosProvider();
  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = HomePage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (_prefs.color) ? Colors.black : Colors.white,
      body: Stack(
        children: <Widget>[
          _fondo(),
          flechaAtras(context),
          _cardProducto(context),
          _descProducto(context, _prefs),
        ],
      ),
    );
  }

  Positioned flechaAtras(BuildContext context) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.chevron_left,
            ),
            iconSize: 40,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _descProducto(BuildContext context, PreferenciasUsuario prefs) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Column(
          children: [
            Container(
              color: (prefs.color) ? Colors.black : Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget.p.nombre}",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: (prefs.color) ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "${widget.p.descripcion}",
                    style: TextStyle(
                        color: (prefs.color) ? Colors.white : Colors.black,
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Counter(),
                      Expanded(child: Container()),
                      Text(
                        "${widget.p.precio}€",
                        style: TextStyle(
                            color: (prefs.color) ? Colors.white : Colors.black,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        "Añadir a la cesta",
                        style: Theme.of(context).textTheme.button.apply(
                              color: Colors.white,
                            ),
                      ),
                      onPressed: () {
                        context.read<Carrito>().addProducto(widget.p);
                      },
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardProducto(BuildContext context) {
    return Positioned(
      top: 150,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Hero(
          tag: widget.p,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "${widget.p.imagen}",
              width: MediaQuery.of(context).size.width * .7,
            ),
          ),
        ),
      ),
    );
  }

  Widget _fondo() {
    return Container(
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/images/fondo1.jpg'),
        fit: BoxFit.fill,
      ),
    );
  }
}
