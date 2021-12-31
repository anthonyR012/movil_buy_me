// ignore_for_file: file_names

class PedidosPojo {
    final String id;
  final String localidad;
  final String estado;
  final String usuario;
  final String id_usuario;
  final String direccion;
  final String fecha_pedido;
  final String cantidad_productos;
  final String total_a_pagar;
  final List<dynamic> productos;

  PedidosPojo(this.id, this.localidad,this.estado, this.usuario,this.id_usuario, this.direccion,this.fecha_pedido, this.cantidad_productos,this.total_a_pagar, this.productos);

  PedidosPojo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        localidad = json['localidad'],
        estado = json['estado'],
        usuario = json['usuario'],
        id_usuario = json['id_usuario'],
        direccion = json['direccion'],
        fecha_pedido = json['fecha_pedido'],
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
       'fecha_pedido': fecha_pedido,
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


      ProductPojo(this.id_producto, this.nombre_producto,this.cantidad_producto,this.precio_producto);

  ProductPojo.fromJson(Map<String, dynamic> json)
      : id_producto = json['id_producto'],
        nombre_producto = json['nombre_producto'],
         cantidad_producto = json['cantidad_producto'],
          precio_producto = json['precio_producto'];

  Map<String, dynamic> toJson() =>
    {
      'id_producto': id_producto,
      'nombre_producto': nombre_producto,
      'cantidad_producto': cantidad_producto,
      'precio_producto': precio_producto,
    };


}