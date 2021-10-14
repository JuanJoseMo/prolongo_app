// To parse this JSON data, do
//
//     final usuarios = usuariosFromJson(jsonString);

import 'dart:convert';

Usuarios usuariosFromJson(String str) => Usuarios.fromJson(json.decode(str));

String usuariosToJson(Usuarios data) => json.encode(data.toJson());

class Usuarios {
    Usuarios({
        this.err,
        this.mensaje,
        this.usuario,
    });

    bool err;
    String mensaje;
    List<Usuario> usuario;

    factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        err: json["err"],
        mensaje: json["mensaje"],
        usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
    };
}

class Usuario {
    Usuario({
        this.id,
        this.nombre,
        this.email,
        this.password,
    });

    int id;
    String nombre;
    String email;
    String password;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
    };
}
