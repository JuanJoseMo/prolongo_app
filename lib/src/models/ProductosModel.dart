// To parse this JSON data, do
//
//     final productos = productosFromJson(jsonString);

import 'dart:convert';

Productos productosFromJson(String str) => Productos.fromJson(json.decode(str));

String productosToJson(Productos data) => json.encode(data.toJson());

class Productos {
    Productos({
        this.err,
        this.total,
        this.totalPag,
        this.pagActual,
        this.pagSiguiente,
        this.pagAnterior,
        this.productos,
    });

    bool err;
    int total;
    int totalPag;
    int pagActual;
    int pagSiguiente;
    int pagAnterior;
    List<Producto> productos;

    factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        err: json["err"],
        total: json["total"],
        totalPag: json["total_pag"],
        pagActual: json["pag_actual"],
        pagSiguiente: json["pag_siguiente"],
        pagAnterior: json["pag_anterior"],
        productos: List<Producto>.from(json["productos"].map((x) => Producto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "total": total,
        "total_pag": totalPag,
        "pag_actual": pagActual,
        "pag_siguiente": pagSiguiente,
        "pag_anterior": pagAnterior,
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
    };
}

class Producto {
    Producto({
        this.id,
        this.nombre,
        this.imagen,
        this.descripcion,
        this.precio,
    });

    String id;
    String nombre;
    String imagen;
    String descripcion;
    String precio;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        precio: json["precio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "descripcion": descripcion,
        "precio": precio,
    };
}
