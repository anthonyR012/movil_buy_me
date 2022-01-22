

 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PedidosPojo.dart';
import 'cardPeditor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class ListPeditor extends StatefulWidget {
  final userInformation;
  ListPeditor(this.userInformation,{Key? key}) : super(key: key);

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
  Future<List<PedidosPojo>> _getPeditorFuture() async{

  var url = Uri.parse('http://192.168.1.50/WEbservice/querys.php?case=pedidos');
      var response = await http.get(url);
       List<PedidosPojo> pedidosCompletos = [];

      if(response.statusCode==200 ){
        
       //Si la respuesta es positiva, guarda la lista de productos
       //en cada item pedido
        try{
          String body = utf8.decode(response.bodyBytes);
          
         var jsonData  = jsonDecode(body); 
          _misPedidosArray = jsonData["response"];
             List<ProductPojo> productos = [];
           
    for (var i = 0; i < _misPedidosArray.length; i++) {
    
      for (var u = 0; u <  _misPedidosArray[i]["productos"].length; u++) {

          var img =  _misPedidosArray[i]["productos"][u]["imagen_producto"].replaceAll("localhost","192.168.1.50");
 
          ProductPojo  producto = new ProductPojo(
            _misPedidosArray[i]["productos"][u]["id_producto"],
           _misPedidosArray[i]["productos"][u]["nombre_producto"],
           _misPedidosArray[i]["productos"][u]["cantidad_producto"],
           _misPedidosArray[i]["productos"][u]["precio_producto"],
           img);
          
            productos.add(producto);
        
           
      }
        late PedidosPojo pedido;
        pedido = PedidosPojo(_misPedidosArray[i]["id"],
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
     
     
      }
    
        

        }catch(e){
          print(e);
        }
      }

   return pedidosCompletos;
 }
  
  @override
    Widget build(BuildContext context) {
      
      return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos '+userInformation['Ciudad']+''),
      ),
      backgroundColor: Colors.blueGrey,
      body: _createWidgeListFuture()
     
      );
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
      builder: (context,snapshot){
        if(snapshot.hasData){
          
          pedidosDimisible = countData(snapshot.data);
          
          return  RefreshIndicator(
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
                      itemBuilder: (BuildContext context,int index){
                           return Dismissible(
                             key:  ObjectKey(pedidosDimisible[index]),
                             child: CardPeditor(pedidosDimisible[index]),
                             confirmDismiss: (direction) {
                               return  showDialog(context: context,builder: 
                                (_) => AlertDialog(
                                  title: Text("Finalizar orden"),
                                  content:  Text("¿Entregaste este pedido?"),
                                  actions:[
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop(true);
                                      
                                      
                                    },
                                    child:  Text('Entregado')
                                    ),
                                    TextButton(onPressed: (){
                                        Navigator.of(context).pop(false);
                                        Scaffold
                                      .of(context)
                                      .showSnackBar(SnackBar(content: Text("Cancelado")));
                                    },
                                    child:  Text('Cancelar')
                                    )
                                  ]
                                  )
                                );
                             },
                             onDismissed: (d){
                               setState(() {
                                 pedidosDimisible.removeAt(index);
                               });
                              
                               
                                 Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text("Completado")));
                             }
                             
                             );
                        
                      }
          )
        );
          
        }else if(snapshot.hasError){
    
         throw snapshot.hasError;
        }
        return const Center(
          child:SpinKitFadingCube(
            color: Colors.white,
            size: 80.0,
          ),
        );
      }
      
      ) ;
  }

  /**
   * Recibe el snapData y convierte a lista de pedidos
   * @param data (snapshot.data)
   * @return List<PedidosPojo> 
   */
  List<PedidosPojo> countData( data) {
    List<PedidosPojo> pedidos = [];
    for(var i in data) {
      pedidos.add(i);

    }
    return pedidos;
  }
  
  
}

