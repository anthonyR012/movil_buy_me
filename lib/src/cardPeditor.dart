import 'package:flutter/material.dart';
import 'PedidosPojo.dart';
import 'detailPeditor.dart';


class CardPeditor extends StatelessWidget {
  /**
   * Recibe el pedido por constructor
   */
  PedidosPojo peditor;
  CardPeditor(this.peditor);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>  DetailPeditor(this.peditor)));
      },
      child: Card(
      child: Column(
        children:<Widget> [
          Container(
            height: 144.0,
            width: 500.0, 
            color: Colors.blueGrey[900],
            child: Image.asset("images/logo.png",height: 144.0,width: 160.0),
          ),
          padding(Text(peditor.usuario+" "+peditor.pago,style: TextStyle(fontSize: 18.0))),
          Row(children: [
           padding(Icon(Icons.access_time_filled_outlined)),
           padding(Text("Entrega para: "+peditor.entregar_en,style: TextStyle(fontSize: 18.0))),
          ],)
        ],
      ),
    ));
  }
  
  Widget padding(Widget widget){
    return Padding(padding: EdgeInsets.all(7.0),child: widget);
  }
}