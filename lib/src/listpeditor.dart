import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PedidosPojo.dart';


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
      body: ListView(
        children: _misPedidos,
      )
      );

    
  }


    void _getPeditor() async {
    
       var url = Uri.parse('http://192.168.1.57/WEbservice/querys.php?case=pedidos');
      var response = await http.get(url);
      
      if(response.statusCode==200 ){
        
       
        try{
          String body = utf8.decode(response.bodyBytes);
          
           var jsonData  = jsonDecode(body); 
          // print(jsonData["response"]);
         var responseArray = jsonData["response"];
          for(int i=0; i<responseArray.length; i++){
                    // print(jsonData["response"][0]["localidad"]);


                    _misPedidos.add(ListTile(
                            title: Text('Usuario: '+responseArray[i]["usuario"]+ ' Pedido de: '+responseArray[i]["localidad"]),
                            subtitle: Text('Estado: '+responseArray[i]["estado"]+' Total a pagar: '+responseArray[i]["total_a_pagar"]),
                            leading: const CircleAvatar(
                              child: Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ));

                  }
        print("Los pedidos son: "+responseArray.toString());
        
        }catch(e){
        print("ob "+e.toString());
         throw 'Err '+e.toString();

        }
      }else{
        throw 'Err connection internet';
      }
  }
}

// class ListPeditor extends StatelessWidget {
//   final userInformation;
//   List<ListTile> _misPedidos = [];  
//   ListPeditor(this.userInformation,{Key? key}) : super(key: key);

//   @override
//   void initState() {
    
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//      String city = userInformation["Ciudad"].toString();
     
      
//       print("peditors "+_misPedidos.toString());
//      return Scaffold(
//       appBar: AppBar(
//         title: Text('Pedidos '+city+''),
//       ),
//       body: ListViewServer());

    
//   }
 

//   Widget ListViewServer(){

//     return ListView(
//         children: _misPedidos,
//       );
//   }

//   List<Widget> ListaPedidos(){

//     _getPeditor();
   
//     // print("dataaaa "+dataListTite.toString());
//     return [];    
//   }

//   void _getPeditor() async {
    
//        var url = Uri.parse('http://192.168.1.57/WEbservice/querys.php?case=pedidos');
//       var response = await http.get(url);
      
//       if(response.statusCode==200 ){
        
       
//         try{
//           String body = utf8.decode(response.bodyBytes);
          
//            var jsonData  = jsonDecode(body); 
//           // print(jsonData["response"]);
         
//           for(int i=0; i<jsonData["response"].length; i++){
//                     // print(jsonData["response"][0]["localidad"]);


//                     _misPedidos.add(const ListTile(
//                             title: Text('Usuario: '),
//                             subtitle: Text('Analisis y desarrollo de sistemas de información'),
//                             leading: CircleAvatar(
//                               child: Image(
//                                 image: AssetImage('images/logo.png'),
//                               ),
//                             ),
//                             trailing: Icon(Icons.arrow_forward_ios),
//                           ));

//                   }
//         print("Los pedidos son: "+_misPedidos.length.toString());
        
//         }catch(e){
//         print("ob "+e.toString());
//          throw 'Err '+e.toString();

//         }
//       }else{
//         throw 'Err connection internet';
//       }
//   }
// }