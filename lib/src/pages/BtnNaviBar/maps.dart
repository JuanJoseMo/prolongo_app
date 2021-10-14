import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prolongo_app/src/pages/home/homePage.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';

class MapsPage extends StatefulWidget {
  static final String routeName = 'maps';
  @override
  State<MapsPage> createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Marker posicionTienda = new Marker(
    position: LatLng(36.73521870174827, -4.608936309814453),
    markerId: MarkerId(
      LatLng(36.73521870174827, -4.608936309814453).toString(),
    ),
  );
  Marker posicionHome = new Marker(
    position: LatLng(37.72103023417879, -3.9697229862213135),
    markerId: MarkerId(
      LatLng(37.72103023417879, -3.9697229862213135).toString(),
    ),
  );
  List<Marker> myMarker = [];
  final _prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = HomePage.routeName;
    myMarker.add(posicionTienda);
    myMarker.add(posicionHome);
  }

  Completer<GoogleMapController> _controller = Completer();

  //Posición inicial de la cámara.
  static final CameraPosition _inicio = CameraPosition(
    target: LatLng(37.72103023417879, -3.9697229862213135),
    zoom: 14,
  );

  //Lugar hasta el que se va a desplazar la cámara cuando pulsemos sobre el botón de la tienda.
  static final CameraPosition _tienda =
      CameraPosition(target: LatLng(36.7352424, -4.6093628), zoom: 17);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _inicio,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(myMarker),
        onTap: _handleTap,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: _goToTheProlongoShop,
        label: Text('Tienda Física'),
        icon: Icon(Icons.local_mall),
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    //LatLng(36.73521870174827, -4.608936309814453)
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(
            tappedPoint.toString(),
          ),
          position: tappedPoint,
        ),
      );
    });
  }

  Future<void> _goToTheProlongoShop() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_tienda));
  }
}
