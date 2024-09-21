import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //obtener coleccion tickets de avion
  final CollectionReference ticketAvion =
      FirebaseFirestore.instance.collection('tickets_avion');

  /*Create: crear tickets de avion con campos: origen, destino, fecha, aerolinea,
  informacion pasajero, numero de asiento, clase, precio)*/
  Future<void> createTicketAvion(
      String origen,
      String destino,
      String fecha,
      String aerolinea,
      String informacionPasajero,
      String numeroAsiento,
      String clase,
      double precio) {
    return ticketAvion.add({
      'origen': origen,
      'destino': destino,
      'fecha': fecha,
      'aerolinea': aerolinea,
      'informacion_pasajero': informacionPasajero,
      'numero_asiento': numeroAsiento,
      'clase': clase,
      'precio': precio,
      'timestamp': Timestamp.now(),
    });
  }

  /*Read: obtener todos los tickets de avion*/

  Stream<QuerySnapshot> getTicketsAvion() {
    final ticketsStream =
        ticketAvion.orderBy('timestamp', descending: true).snapshots();

    return ticketsStream;
  }

  /*Update: actualizar un ticket de avion*/
  Future<void> updateTicketAvion(
      String id,
      String origen,
      String destino,
      String fecha,
      String aerolinea,
      String informacionPasajero,
      String numeroAsiento,
      String clase,
      double precio) {
    return ticketAvion.doc(id).update({
      'origen': origen,
      'destino': destino,
      'fecha': fecha,
      'aerolinea': aerolinea,
      'informacion_pasajero': informacionPasajero,
      'numero_asiento': numeroAsiento,
      'clase': clase,
      'precio': precio,
      'timestamp': Timestamp.now(),
    });
  }

  /*Delete: eliminar un ticket de avion*/
  Future<void> deleteTicketAvion(String id) {
    return ticketAvion.doc(id).delete();
  }
}
