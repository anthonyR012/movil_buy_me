

class PedidosPojo {
    final String id;
  final String localidad;
  final String estado;
  final String usuario;
  final String id_usuario;
  final String direccion;
  final String tomado_en;
  final String entregar_en;
  final String cantidad_productos;
  final String total_a_pagar;
  final String pago;
  final List<ProductPojo> productos;
 

  PedidosPojo(this.id, this.localidad,this.estado, this.usuario,this.id_usuario, this.direccion,this.tomado_en,this.entregar_en,this.pago, this.cantidad_productos,this.total_a_pagar, this.productos);

  PedidosPojo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        localidad = json['localidad'],
        estado = json['estado'],
        usuario = json['usuario'],
        id_usuario = json['id_usuario'],
        direccion = json['direccion'],
        tomado_en = json['tomado_en'],
        entregar_en = json['entregar_en'],
        pago = json['pago'],
        cantidad_productos = json['cantidad_productos'],
        total_a_pagar = json['total_a_pagar'],
        productos = json['productos'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'localidad': localidad,
       'estado': estado,
      'usuario': usuario,
       'id_usuario': id_usuario,
      'direccion': direccion,
       'tomado_en': tomado_en,
       'entregar_en': entregar_en,
        'pago': pago,
      'cantidad_productos': cantidad_productos,
       'total_a_pagar': total_a_pagar,
      'productos': productos,
    };

    
}

class ProductPojo{
  final String id_producto;
  final String nombre_producto;
  final String cantidad_producto;
  final String precio_producto;
 final String imagen_producto;

      ProductPojo(this.id_producto, this.nombre_producto,this.cantidad_producto,this.precio_producto,this.imagen_producto);

  ProductPojo.fromJson(Map<String, dynamic> json)
      : id_producto = json['id_producto'],
        nombre_producto = json['nombre_producto'],
         cantidad_producto = json['cantidad_producto'],
          precio_producto = json['precio_producto'],
          imagen_producto = json['imagen_producto'];

  Map<String, dynamic> toJson() =>
    {
      'id_producto': id_producto,
      'nombre_producto': nombre_producto,
      'cantidad_producto': cantidad_producto,
      'precio_producto': precio_producto,
      'imagen_producto': imagen_producto,
    };


}