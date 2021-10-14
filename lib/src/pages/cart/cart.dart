import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prolongo_app/src/models/ProductosModel.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';
import 'package:prolongo_app/src/providers/Resp_provider.dart';
import 'package:prolongo_app/src/widgets/myBehavior.dart';

import 'carrito.dart';

class CartPage extends StatefulWidget {
  static final String routeName = 'card';
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductosProvider prodProvi = new ProductosProvider();
  final _prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = HomePage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (_prefs.color ?? false) ? Colors.black : Colors.white,
      body: Container(
        color: (_prefs.color ?? false) ? Colors.black : Colors.white,
        child: Stack(
          children: [
            _crearFondo(context),
            ScrollConfiguration(
              //Lo utilizamos para quitar el sombreado del scroll.
              behavior: MyBehavior(),
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: (context.watch<Carrito>().carrito.length != 0)
                    ? Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: ListView.builder(
                              itemCount:
                                  context.watch<Carrito>().carrito.length,
                              itemBuilder: (BuildContext context, int i) {
                                return buildContainer(
                                    context.watch<Carrito>().carrito[i]);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'El envío será de 2,99 €/envío para entregas en puntos de recogida y 3,99 €/envío para entregas en otras direcciones',
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.green,
                            onPressed: () {},
                            child: Text(
                              'Comprar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Center(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                child: Image(
                                  image: AssetImage('assets/images/cart.gif'),
                                )),
                          ),
                          Center(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Image(
                                  image:
                                      AssetImage('assets/images/sadCart.png'),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Todavía no ha añadido productos a su carrito',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text('Atrás')),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imagenFondo = Container(
        height: size.height * 0.4,
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/fondo1.jpg'),
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
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/logoProlongo.png'),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Carrito de compra",
                    style: TextStyle(
                        fontSize: 35,
                        color: (_prefs.color ?? false)
                            ? Colors.white
                            : Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildContainer(Producto snapshot) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${snapshot.nombre}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: (_prefs.color ?? false) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                //Imagen final
                image: NetworkImage('${snapshot.imagen}'),
                fit: BoxFit.fill,
              ),
            ),
            trailing: Text('${snapshot.precio}€'),
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
