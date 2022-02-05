import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gobuyme/main.dart';
import '../constants.dart';
import '../model/PedidosPojo.dart';

class DetailPeditor extends StatefulWidget {
  final PedidosPojo pedido;
  DetailPeditor(this.pedido, {Key? key}) : super(key: key);

  @override
  State<DetailPeditor> createState() => _DetailPeditorState();
}

class _DetailPeditorState extends State<DetailPeditor> {
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: 250,
              width: 500,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              margin: EdgeInsets.only(left: 5, top: 30, right: 0, bottom: 0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset("images/baner.jpg"),
            ),
            containerWidge('Detalle del pedido ', Icons.trip_origin_sharp, 26,
                Colors.white),
            containerWidge(
                widget.pedido.usuario + " ", Icons.person, 20, Colors.black),
            containerWidge(
                widget.pedido.direccion, Icons.approval, 20, Colors.black),
            createCarrousel(),
            containerWidge("Cancela "+ widget.pedido.total_a_pagar+" Pesos",Icons.attach_money_outlined,23,Colors.black)
          ],
        ));
  }

  Widget createCarrousel() {
    return Positioned(
       
        right:0,
        left: 0,
        height: 200,
        child: CarouselSlider(
          options: CarouselOptions(height: 200.0),
          items: widget.pedido.productos.map((i) {
            return Builder(
              builder: (BuildContext context) {
                
                return Stack(
                  children: [
                    Container(
                     
                          child: Image.network(i.imagen_producto, width: 200),
                        ),
                        
                    getInformation(i),
                  ],
                );
              },
            );
          }).toList(),
        ));
  }

  Widget containerWidge(String title, icon, double fontSize, color) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(icon),
            Text(title,
                style: TextStyle(
                    color: color, fontSize: fontSize, fontFamily: 'Arial')),
          ],
        ));
  }

  Widget getInformation(ProductPojo i) {

    
     return  Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(i.nombre_producto + " \$ " + i.precio_producto + " Pesos",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 14, fontFamily: 'Arial')));
    
  }
}
