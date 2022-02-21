import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gobuyme/src/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/PedidosPojo.dart';
import 'cardPeditor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListPeditor extends StatefulWidget {
  final userInformation;
  ListPeditor(this.userInformation, {Key? key}) : super(key: key);

  @override
  _ListPeditorState createState() => _ListPeditorState(userInformation);
}

class _ListPeditorState extends State<ListPeditor> {
  /*****
   * Variables
   */
  final userInformation;
  _ListPeditorState(this.userInformation);
  List _misPedidosArray = [];
  late Future<List<PedidosPojo>> _pedidos;
  List<PedidosPojo> pedidosDimisible = [];
  bool isReadyUpdate = true;

  late Timer timer;

  /**
   * Metodo inicializador, que solicita peticion http guarda en la lista future
   */
  @override
  void initState() {
    super.initState();
    _pedidos = _getPeditorFuture();
  }

  /**
   * Metodo asincrono que trae respuesta futura de lista de pedidos
   * @return  Future<List<PedidosPojo>> Lista pedidos
   */
  Future<List<PedidosPojo>> _getPeditorFuture() async {
    var url = Uri.parse(
        BASE_URL + 'search.php?case=pedidos&searchState=activo');
    var response = await http.get(url);
    List<PedidosPojo> pedidosCompletos = [];

    if (response.statusCode == 200) {
      //Si la respuesta es positiva, guarda la lista de productos
      //en cada item pedido
      try {
        String body = utf8.decode(response.bodyBytes);

        var jsonData = jsonDecode(body);
        _misPedidosArray = jsonData["response"];
        List<ProductPojo> productos = [];
        int len = _misPedidosArray.length;
        late PedidosPojo pedido;
        if (len > 1) {
          for (var i = 0; i < _misPedidosArray.length; i++) {
            for (var u = 0; u < _misPedidosArray[i]["productos"].length; u++) {
              var img = _misPedidosArray[i]["productos"][u]["imagen_producto"]
                  .replaceAll("localhost", IP);

              ProductPojo producto = new ProductPojo(
                  _misPedidosArray[i]["productos"][u]["id_producto"],
                  _misPedidosArray[i]["productos"][u]["nombre_producto"],
                  _misPedidosArray[i]["productos"][u]["cantidad_producto"],
                  _misPedidosArray[i]["productos"][u]["precio_producto"],
                  img);

              productos.add(producto);
            }

            pedido = PedidosPojo(
                _misPedidosArray[i]["id"],
                _misPedidosArray[i]["localidad"],
                _misPedidosArray[i]["estado"],
                _misPedidosArray[i]["usuario"],
                _misPedidosArray[i]["id_usuario"],
                _misPedidosArray[i]["direccion"],
                _misPedidosArray[i]["tomado_en"],
                _misPedidosArray[i]["entregar_en"],
                _misPedidosArray[i]["pago"],
                _misPedidosArray[i]["cantidad_productos"],
                _misPedidosArray[i]["total_a_pagar"],
                productos);

            pedidosCompletos.add(pedido);

            productos = [];
          }
          print(pedidosCompletos);
        } else {
          int lenProducts = _misPedidosArray[0]["productos"].length;
          late ProductPojo producto;

          if (lenProducts == 1) {
            print(_misPedidosArray[0]["productos"]);
            var img = _misPedidosArray[0]["productos"][0]["imagen_producto"]
                .replaceAll("localhost", IP);

            producto = new ProductPojo(
                _misPedidosArray[0]["productos"][0]["id_producto"],
                _misPedidosArray[0]["productos"][0]["nombre_producto"],
                _misPedidosArray[0]["productos"][0]["cantidad_producto"],
                _misPedidosArray[0]["productos"][0]["precio_producto"],
                img);

            productos.add(producto);
          } else {
            for (var u = 0; u < _misPedidosArray[0]["productos"].length; u++) {
              var img = _misPedidosArray[0]["productos"][u]["imagen_producto"]
                  .replaceAll("localhost", IP);

              producto = new ProductPojo(
                  _misPedidosArray[0]["productos"][u]["id_producto"],
                  _misPedidosArray[0]["productos"][u]["nombre_producto"],
                  _misPedidosArray[0]["productos"][u]["cantidad_producto"],
                  _misPedidosArray[0]["productos"][u]["precio_producto"],
                  img);
            }

            productos.add(producto);
          }

          pedido = PedidosPojo(
              _misPedidosArray[0]["id"],
              _misPedidosArray[0]["localidad"],
              _misPedidosArray[0]["estado"],
              _misPedidosArray[0]["usuario"],
              _misPedidosArray[0]["id_usuario"],
              _misPedidosArray[0]["direccion"],
              _misPedidosArray[0]["tomado_en"],
              _misPedidosArray[0]["entregar_en"],
              _misPedidosArray[0]["pago"],
              _misPedidosArray[0]["cantidad_productos"],
              _misPedidosArray[0]["total_a_pagar"],
              productos);

          pedidosCompletos.add(pedido);
        }
      } catch (e) {
        print("err " + e.toString());
      }
    }
    print(pedidosCompletos);
    return pedidosCompletos;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: COLORSECONDARY,
          title: Text('Pedidos ' + userInformation['Ciudad'] + ''),
        ),
        body:Container(
          height: 900,
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops:ARRAYHEXADECIMAL,
              colors: ARRAYCOLORS,
            )
          ),
          child:_createWidgeListFuture()),
        ));
        
  }

  /**
   * Crea lista de widgets cuando la respuesta llega
   * arbol de Wiidge (FutureBuilder, RefreshIndicator, Dismissible, ListView, CardView)
   * 
   * Despliegue alerta en onDismissed 
   */
  Widget _createWidgeListFuture() {
    return FutureBuilder(
        future: _pedidos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            pedidosDimisible = countData(snapshot.data);

            isReadyUpdate = false;
            return RefreshIndicator(
                backgroundColor: Colors.blue,
                displacement: 40.0,
                strokeWidth: 4,
                onRefresh: () {
                  _pedidos = _getPeditorFuture();
                  setState(() {
                    _pedidos;
                  });
                  return _pedidos;
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pedidosDimisible.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          key: ObjectKey(pedidosDimisible[index]),
                          child: CardPeditor(pedidosDimisible[index]),
                          confirmDismiss: (direction) {
                            return showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                        title: Text("Finalizar orden"),
                                        content:
                                            Text("¿Entregaste este pedido?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                _pedidorFinished(
                                                    pedidosDimisible[index].id);

                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text('Entregado')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text("Cancelado")));
                                              },
                                              child: Text('Cancelar'))
                                        ]));
                          },
                          onDismissed: (d) {
                            _pedidos = _getPeditorFuture();
                            new Future.delayed(const Duration(seconds: 5), () {
                              setState(() {
                                _pedidos;

                                pedidosDimisible.removeAt(index);
                              });
                            });

                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Completado")));
                          });
                    }));
          } else if (snapshot.hasError) {
            throw snapshot.hasError;
          }
          return const Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 80.0,
            ),
          );
        });
  }

  /**
   * Recibe el snapData y convierte a lista de pedidos
   * @param data (snapshot.data)
   * @return List<PedidosPojo> 
   */
  List<PedidosPojo> countData(data) {
    List<PedidosPojo> pedidos = [];
    for (var i in data) {
      pedidos.add(i);
    }
    return pedidos;
  }

  void _pedidorFinished(id) async {
    var url =
        Uri.parse(BASE_URL + 'update.php?case=entregado&id=' + id);
    print(url);
    var response = await http.get(url);
    List<PedidosPojo> pedidosCompletos = [];
    print("ejecutando actualizacion");
    if (response.statusCode == 200) {
      //Si la respuesta es positiva, guarda la lista de productos
      //en cada item pedido
      try {
        String body = utf8.decode(response.bodyBytes);
        print("actualizo");
        isReadyUpdate = true;
        var jsonData = jsonDecode(body);
        var resulset = jsonData["response"];
        //  if(resulset.response=="update complete"){
        //    print("Actualizacion completa");
        //  }else{
        //    print("No actualizo");
        //  }

      } catch (e) {
        print(e);
      }
    }
  }
}
