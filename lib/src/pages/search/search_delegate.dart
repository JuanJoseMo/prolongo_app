import 'package:flutter/material.dart';
import 'package:prolongo_app/src/models/ProductosModel.dart';
import 'package:prolongo_app/src/providers/Resp_provider.dart';

import '../productDetail/productDetail.dart';

class ProductosSearch extends SearchDelegate {
  //static final String routeName = 'search';
  //Ponemos en la caja un texto por defecto.
  final searchFieldLabel = 'Búsqueda';

  final productosProvider = new ProductosProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones del AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            //Variable query hace referencia a la caja de texto, ya que viene implicita en el SearchDelegate.
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono de la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          //Metodo close para cerrar, ya que viene en el SearchDelegate.
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados a mostrar.
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.buscarProducto(query),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.hasData) {
          //La búsqueda nos devolverá la lista de productos total.
          //En función de nuestro texto en la caja de búsqueda nos devolverá una lista con los productos que contengan ese texto.
          final productos = snapshot.data;
          print('${productos.length}');
          return ListView(
            children: productos.map(
              (producto) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductoDetalle(
                            p: producto,
                          ),
                        ),
                      );
                    },
                    leading: Hero(
                      tag: producto,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/loading.gif'),
                          image: NetworkImage(producto.imagen),
                          width: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: Text(producto.nombre),
                  ),
                );
              },
            ).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
