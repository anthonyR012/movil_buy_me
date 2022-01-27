import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/PedidosPojo.dart';

class DetailPeditor extends StatelessWidget {
  final PedidosPojo pedido;
   const DetailPeditor(this.pedido, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
            backgroundColor: Colors.blueGrey,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Container( 
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: Text('Orden #'+pedido.id, style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Arial'
                          )
                          )

                      ),
                  ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Column(
                       
                        children: [
                          
                              Text('Cliente: '+pedido.usuario, style: 
                              TextStyle(
                                
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial'
                                
                                )
                                ),
                                  Text(pedido.pago, style: 
                              TextStyle(
                                
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial'
                                
                                )
                                )
                                
                        ],
                      ),
                       Column(
                        children: [
                              Text('   Dirección: '+pedido.direccion, style: 
                              TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial'
                                )
                                ),
                                  Text('Total: '+pedido.total_a_pagar, style: 
                              TextStyle(
                                
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Arial'
                                
                                )
                                )
                        ],
                      ),
                    ]
                  ),
                
                  CarouselSlider(
                  options: CarouselOptions(height: 400.0),
                  items: pedido.productos.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack( 
                      
                        children: [ 
                          Image.network(i.imagen_producto,width: 200),
                          Container( 
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            child: Text(i.nombre_producto+" \$ "+i.precio_producto+" Pesos", style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Arial'
                              )
                              )
                          ),
                          
                        ],
                      );
                      },
                    );
                  }).toList(),
                )
              ],
            )
          )
        )
      );
  }
}