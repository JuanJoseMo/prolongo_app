import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prolongo_app/src/models/ProductosModel.dart';
import 'package:prolongo_app/src/pages/cart/carrito.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/pages/productDetail/productDetail.dart';
import 'package:prolongo_app/src/pages/search/search_delegate.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';
import 'package:prolongo_app/src/providers/Resp_provider.dart';
import 'package:prolongo_app/src/widgets/myBehavior.dart';

class ShopPage extends StatefulWidget {
  static final String routeName = 'shop';
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ProductosProvider prodProvi = new ProductosProvider();
  final _prefs = new PreferenciasUsuario();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = HomePage.routeName;
    //Posicion del inicio del scroll de nuestro gridview para el catálogo.
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    //Momento donde evaluamos si nuestro scroll ha llegado a el máximo de la pantalla para pedir los datos de nuevo a la página.
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        prodProvi.getProductos();
        print('He llegado al final.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    prodProvi.getProductos();
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
                  child: StreamBuilder<List<Producto>>(
                    initialData: [],
                    stream: prodProvi.productosStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Producto>> snapshot) {
                      if (snapshot.hasData) {
                        //Con los datos que nos traemos vamos a ir moldeando el catálogo con un gridview.
                        return GridView.builder(
                          controller: _scrollController,
                          //Personalización del gridview
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.80,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int i) {
                            return buildContainer(snapshot.data[i]);
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
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
            child: Row(
          children: [
            Expanded(
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CircleAvatar(
                radius: 10,
                child: Text(
                  '${context.watch<Carrito>().carrito.length}',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        )),
        SafeArea(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: 0,
              )),
              IconButton(
                icon: Icon(Icons.search,
                    color:
                        (_prefs.color ?? false) ? Colors.white : Colors.black),
                onPressed: () {
                  showSearch(context: context, delegate: ProductosSearch());
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart,
                    color:
                        (_prefs.color ?? false) ? Colors.white : Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, 'card');
                },
              ),
            ],
          ),
        ),
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
                    "Catálogo",
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
    return Container(
      child: Column(
        children: [
          Text(
            '${snapshot.nombre}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: (_prefs.color ?? false) ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11),
          ),
          Hero(
            tag: snapshot,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/loading.gif'),
                //Imagen final
                image: NetworkImage('${snapshot.imagen}'),
                //Tamaño configurable
                height: 125,
                width: 125,
                fit: BoxFit.fill,
              ),
            ),
          ),
          FlatButton(
              onPressed: () {
                //Botón que nos llevará a una página con la información del producto. Para esto tenemos que pasarle el producto.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductoDetalle(
                      p: snapshot,
                    ),
                  ),
                );
              },
              child: Text(
                'Más información',
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
    );
  }
}
