import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PedidosPojo.dart';
import 'detailPeditor.dart';


class ListPeditor extends StatefulWidget {
  final userInformation;
  ListPeditor(this.userInformation,{Key? key}) : super(key: key);

  @override
  _ListPeditorState createState() => _ListPeditorState(userInformation);
}

class _ListPeditorState extends State<ListPeditor> {
  final userInformation;
  _ListPeditorState(this.userInformation);
  List<ListTile> _misPedidos = [];  
  List _misPedidosArray = [];
  @override
  void initState() {
   print("carga actividad "+userInformation.toString());
    super.initState();
    _getPeditor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos '+userInformation['Ciudad']+''),
      ),
      body:  
      ListView(
        children: _misPedidos,
        
      )
      );

    
  }

  void _detallePedido(String id){
    late PedidosPojo pedido;
    List<ProductPojo> productos = [];
    for (var i = 0; i < _misPedidosArray.length; i++) {
     
      if(_misPedidosArray[i]["id"] == id){
      for (var u = 0; u <  _misPedidosArray[i]["productos"].length; u++) {

          var img =  _misPedidosArray[i]["productos"][u]["imagen_producto"].replaceAll("localhost","192.168.1.50");

          ProductPojo producto = new ProductPojo(
            _misPedidosArray[i]["productos"][u]["id_producto"],
           _misPedidosArray[i]["productos"][u]["nombre_producto"],
           _misPedidosArray[i]["productos"][u]["cantidad_producto"],
           _misPedidosArray[i]["productos"][u]["precio_producto"],
           img);
          
            productos.add(producto);
        
            print(producto.imagen_producto);
      }
        
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

      }
      
    }
     Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>  DetailPeditor(pedido)));
  }
    void _getPeditor() async {
    
       var url = Uri.parse('http://192.168.1.50/WEbservice/querys.php?case=pedidos');
      var response = await http.get(url);
      
      if(response.statusCode==200 ){
        
       
        try{
          String body = utf8.decode(response.bodyBytes);
          
         var jsonData  = jsonDecode(body); 
          // print(jsonData["response"]);
         _misPedidosArray = jsonData["response"];
          for(int i=0; i<_misPedidosArray.length; i++){
                    // print(jsonData["response"][0]["localidad"]);


                    
                    _misPedidos.add(ListTile(
                            title: Text('Usuario: '+_misPedidosArray[i]["usuario"]+ ' Pedido de: '+_misPedidosArray[i]["localidad"]),
                            subtitle: Text('Estado: '+_misPedidosArray[i]["estado"]+' Total a pagar: '+_misPedidosArray[i]["total_a_pagar"]),
                            leading: const CircleAvatar(
                              child: Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            ),
                            trailing:  ElevatedButton(
                              // color: Colors.transparent,
                                onPressed: () {
                                  _detallePedido(_misPedidosArray[i]["id"]);
                                },
                                child: Icon(Icons.arrow_forward_ios),
                
                              )
                            
                            
                          ));

                  }
        print("Los pedidos son: "+_misPedidosArray.toString());
        
        }catch(e){
        print("ob "+e.toString());
         throw 'Err '+e.toString();

        }
      }else{
        throw 'Err connection internet';
      }
  }
}

