import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'validators.dart';

class BlocController extends Validators {
  final _nombreController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  //Insertar valores al Stream
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  //Leer los datos del Stream
  Stream<String> get nombreStream => _nombreController.stream;

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);

  Stream<String> get passStream =>
      _passController.stream.transform(validarPass);

  //Uno los stream para saber si el formulario es valido
  Stream<bool> get formValidLoginStream =>
      Rx.combineLatest2(emailStream, passStream, (e, p) => true);
  Stream<bool> get formValidRegistroStream => Rx.combineLatest3(
      nombreStream, emailStream, passStream, (n, e, p) => true);

  //Este callback significa que cuando haya datos en ambos, devuelve true.
  //En nuestro caso, los datos existen cuando se cumplen las condiciones de las validaciones
  String get nombre => _nombreController.value;
  String get email => _emailController.value;
  String get password => _passController.value;

  dispose() {
    _nombreController?.close();
    _emailController?.close();
    _passController?.close();
  }
}
