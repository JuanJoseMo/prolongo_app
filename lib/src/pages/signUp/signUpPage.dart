import 'package:flutter/material.dart';
import 'package:prolongo_app/src/pages/Bloc/blocController.dart';
import 'package:prolongo_app/src/pages/Bloc/provider.dart';
import 'package:prolongo_app/src/pages/shared_prefs/preferencias_usuario.dart';
import 'package:prolongo_app/src/providers/Resp_provider.dart';

class SignUpPage extends StatefulWidget {
  static final String routeName = 'signUp';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usuarioProvider = new UsuariosProvider();
  final _prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _prefs.ultimaPagina = SignUpPage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (_prefs.color) ? Colors.black : Colors.white,
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    final size = MediaQuery.of(context).size;
    final imagenFondo = Container(
        height: size.height * 0.4,
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/fondo3.jpg'),
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
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(children: [
            Image(
              image: AssetImage('assets/images/logo2.png'),
              width: 125,
              height: 125,
            ),
            SizedBox(
              height: 25.0,
              width: double.infinity,
            ),
          ]),
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final _prefs = new PreferenciasUsuario();
    //Recuperamos el bloc que esta en el provider
    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: 180.0)),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: (_prefs.color) ? Colors.white : Colors.black45,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: [
                Text('Registro',
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
                SizedBox(
                  height: 20.0,
                ),
                _crearInputNombre(bloc),
                SizedBox(
                  height: 20.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 20.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 20.0,
                ),
                _crearBtn(bloc),
                SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  child: Container(
                    child: Text(
                        'Si ya tienes cuenta puede\n iniciar sesión pulsado aquí',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearInputNombre(BlocController bloc) {
    //Devuelvo un streamBuilder que vamos a usar para meter el nombre en el bloc
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot data) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            //Primera letra en mayúscula.
            textCapitalization: TextCapitalization.words,
            cursorColor: Colors.red,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.contact_mail,
                  color: Colors.red,
                ),
                errorText: data.error,
                labelText: 'Nombre'),
            onChanged: (data) => bloc.changeNombre(data),
          ),
        );
      },
    );
  }

  Widget _crearEmail(BlocController bloc) {
    //Devuelvo un streamBuilder que vamos a usar para meter el email en el bloc
    //Cambiar por un getbuilder
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot data) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            cursorColor: Colors.red,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.red,
                ),
                errorText: data.error,
                hintText: 'usuario@usuario.com',
                labelText: 'Correo electrónico'),
            onChanged: (data) => bloc.changeEmail(data),
          ),
        );
      },
    );
  }

  Widget _crearPassword(BlocController bloc) {
    return StreamBuilder(
      stream: bloc.passStream,
      builder: (BuildContext context, AsyncSnapshot data) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            cursorColor: Colors.red,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    color: Colors.red, width: 1, style: BorderStyle.solid),
              ),
              labelStyle: TextStyle(color: Colors.black),
              icon: Icon(
                Icons.lock_outline,
                color: Colors.red,
              ),
              labelText: 'Contraseña',
              errorText: data.error,
            ),
            onChanged: (data) => bloc.changePass(data),
          ),
        );
      },
    );
  }

  Widget _crearBtn(BlocController bloc) {
    return StreamBuilder(
      stream: bloc.formValidRegistroStream,
      builder: (BuildContext context, AsyncSnapshot data) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Registrarse',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: data.hasData
                  ? () {
                      //Lanzará el registro.
                      _usuarioProvider
                          .registro(bloc.nombre, bloc.email, bloc.password)
                          .then(
                        (usuario) {
                          if (usuario != null) {
                            Navigator.pushNamed(context, 'login');
                          } else {
                            print('Hay ya un usuario con ese correo');
                            _showToast(context);
                          }
                        },
                      );
                    }
                  : null),
        );
      },
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Existe ya un usuario con ese correo'),
      ),
    );
  }
}
