import 'package:flutter/material.dart';

import 'blocController.dart';

class Provider extends InheritedWidget {
  //Aquí podríamos meter otros block que nos interese
  final loginBloc = BlocController();

  //Contructor
  Provider({Key key, Widget child}) : super(key: key, child: child);
  
  //Método obligatorio. Queremos que se notifique a los hijos cuando algun dato cambie
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Obtener el estado del bloc, se puede llamar desde cualquier sitio de mi app
  static BlocController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
