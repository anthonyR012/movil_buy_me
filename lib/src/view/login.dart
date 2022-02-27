import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gobuyme/src/constants.dart';
import 'package:http/http.dart' as http;
import 'listpeditor.dart';


class Login extends StatefulWidget {
  static String id = "login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Future _loginNow;
  final _user = TextEditingController();
  final _pass = TextEditingController();

  /**
   * Consulta api, si concuerdan las credenciales
   */
  Future _getState() async {
    if (_user.text.length > 5 &&
        _user.text.isNotEmpty &&
        _pass.text.length > 3 &&
        _pass.text.isNotEmpty) {
      var url = Uri.parse(BASE_URL + 'Search.php?case=login');
      
      var response = await http.post(url,
          body: {'searchEmail': _user.text, 'searchPass': _pass.text});
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        try {
          final jsonData = jsonDecode(body);
          print(jsonData["response"]);
          if(jsonData["response"]["response"]!="No_found_user" && jsonData["response"]["response"]!="Login_failed"){
                Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListPeditor(jsonData["response"])));
     
          }else{
             _showMyDialog(this.context, "Tus credenciales no son correctas :( ");
          }
          //NAVEGAR SEGUNDO FRAGMENTO
          } catch (e) {
          _showMyDialog(this.context, "Tus credenciales no son correctas :( ");
          //  print("No encontro");
        }
      }
    } else {
      _showMyDialog(this.context, "No pueden haber campos vacios");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:   
        Scaffold(
            body: Container(
               decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops:ARRAYHEXADECIMAL,
              colors: ARRAYCOLORS,
            )
          ),
            child: 
            Center(
              
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Image.asset('images/logo.png', height: 200.0)),
                SizedBox(height: 15.0),
                _userTextField(),
                SizedBox(height: 15.0),
                _passwordTextField(),
                SizedBox(height: 20.0),
                _bottonLogin()
              ],
            )))));
  }

  /**
   * Metodos privados para widgets de campos login
   */
  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextField(
          controller: _user,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'user@example.com',
            labelText: 'Correo electronico',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextField(
          controller: _pass,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: '*******',
            labelText: 'Contraseña',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: _getState,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Iniciar Sesion"),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
          elevation: MaterialStateProperty.all(15),
        ),
      );
    });
  }

  /**
   * Retorna alerta
   */
  Widget _buildAlertDialog(String message) {
    return AlertDialog(
      title: Text('Notificación'),
      content: Text(message),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Aceptar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.black12)),
        )
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (_) => _buildAlertDialog(message),
    );
  }
}
