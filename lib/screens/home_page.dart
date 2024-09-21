import 'package:examen2_programovil/servicios/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();

  // Controladores de texto para los diferentes campos
  final TextEditingController origenController = TextEditingController();
  final TextEditingController destinoController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController aerolineaController = TextEditingController();
  final TextEditingController infoPasajeroController = TextEditingController();
  final TextEditingController numeroAsientoController = TextEditingController();
  final TextEditingController claseController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  bool isLoading = false;

  // Método para agregar un nuevo ticket
  void openTicketsBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Agregar nuevo ticket"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: origenController,
                decoration: const InputDecoration(hintText: "Origen"),
              ),
              TextField(
                controller: destinoController,
                decoration: const InputDecoration(hintText: "Destino"),
              ),
              TextField(
                controller: fechaController,
                decoration:
                    const InputDecoration(hintText: "Fecha (DD/MM/AAAA)"),
              ),
              TextField(
                controller: aerolineaController,
                decoration: const InputDecoration(hintText: "Aerolínea"),
              ),
              TextField(
                controller: infoPasajeroController,
                decoration:
                    const InputDecoration(hintText: "Información del Pasajero"),
              ),
              TextField(
                controller: numeroAsientoController,
                decoration:
                    const InputDecoration(hintText: "Número de Asiento"),
              ),
              TextField(
                controller: claseController,
                decoration: const InputDecoration(hintText: "Clase"),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(hintText: "Precio"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (origenController.text.isNotEmpty &&
                  destinoController.text.isNotEmpty &&
                  fechaController.text.isNotEmpty &&
                  aerolineaController.text.isNotEmpty &&
                  infoPasajeroController.text.isNotEmpty &&
                  numeroAsientoController.text.isNotEmpty &&
                  claseController.text.isNotEmpty &&
                  precioController.text.isNotEmpty) {
                setState(() => isLoading = true);
                try {
                  await firestoreService.createTicketAvion(
                    origenController.text,
                    destinoController.text,
                    fechaController.text,
                    aerolineaController.text,
                    infoPasajeroController.text,
                    numeroAsientoController.text,
                    claseController.text,
                    double.parse(precioController.text),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ticket creado con éxito")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al crear ticket: $e")),
                  );
                } finally {
                  setState(() => isLoading = false);
                  // Limpia todos los campos de texto
                  origenController.clear();
                  destinoController.clear();
                  fechaController.clear();
                  aerolineaController.clear();
                  infoPasajeroController.clear();
                  numeroAsientoController.clear();
                  claseController.clear();
                  precioController.clear();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Todos los campos son obligatorios")),
                );
              }
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
    );
  }

//Metodo para actualizar un ticket
  void openUpdateTicketBox(
      String id,
      String origen,
      String destino,
      String fecha,
      String aerolinea,
      String informacionPasajero,
      String numeroAsiento,
      String clase,
      double precio) {
    origenController.text = origen;
    destinoController.text = destino;
    fechaController.text = fecha;
    aerolineaController.text = aerolinea;
    infoPasajeroController.text = informacionPasajero;
    numeroAsientoController.text = numeroAsiento;
    claseController.text = clase;
    precioController.text = precio.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Actualizar ticket"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: origenController,
                decoration: const InputDecoration(hintText: "Origen"),
              ),
              TextField(
                controller: destinoController,
                decoration: const InputDecoration(hintText: "Destino"),
              ),
              TextField(
                controller: fechaController,
                decoration:
                    const InputDecoration(hintText: "Fecha (DD/MM/AAAA)"),
              ),
              TextField(
                controller: aerolineaController,
                decoration: const InputDecoration(hintText: "Aerolínea"),
              ),
              TextField(
                controller: infoPasajeroController,
                decoration:
                    const InputDecoration(hintText: "Información del Pasajero"),
              ),
              TextField(
                controller: numeroAsientoController,
                decoration:
                    const InputDecoration(hintText: "Número de Asiento"),
              ),
              TextField(
                controller: claseController,
                decoration: const InputDecoration(hintText: "Clase"),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(hintText: "Precio"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (origenController.text.isNotEmpty &&
                  destinoController.text.isNotEmpty &&
                  fechaController.text.isNotEmpty &&
                  aerolineaController.text.isNotEmpty &&
                  infoPasajeroController.text.isNotEmpty &&
                  numeroAsientoController.text.isNotEmpty &&
                  claseController.text.isNotEmpty &&
                  precioController.text.isNotEmpty) {
                setState(() => isLoading = true);
                try {
                  await firestoreService.updateTicketAvion(
                    id,
                    origenController.text,
                    destinoController.text,
                    fechaController.text,
                    aerolineaController.text,
                    infoPasajeroController.text,
                    numeroAsientoController.text,
                    claseController.text,
                    double.parse(precioController.text),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Ticket actualizado con éxito")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al actualizar ticket: $e")),
                  );
                } finally {
                  setState(() => isLoading = false);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Todos los campos son obligatorios")),
                );
              }
            },
            child: const Text("Actualizar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tickets de Avion")),
      floatingActionButton: FloatingActionButton(
        onPressed: openTicketsBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: firestoreService.getTicketsAvion(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error al obtener los tickets"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tickets = snapshot.data.docs;

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return ListTile(
                title: Text("Pasajero: " + ticket['informacion_pasajero']),
                subtitle: Text(
                  "Origen: " +
                      ticket['origen'] +
                      " - Destino: " +
                      ticket['destino'] +
                      " - Aerolínea: " +
                      ticket['aerolinea'] +
                      " - Clase: " +
                      ticket['clase'],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        openUpdateTicketBox(
                          ticket.id,
                          ticket['origen'],
                          ticket['destino'],
                          ticket['fecha'],
                          ticket['aerolinea'],
                          ticket['informacion_pasajero'],
                          ticket['numero_asiento'],
                          ticket['clase'],
                          ticket['precio'],
                        );
                      },
                      icon: const Icon(Icons.settings),
                    ),
                    IconButton(
                      onPressed: () async {
                        // confirmacion antes de eliminar
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Confirmar Eliminación"),
                              content: const Text(
                                  "¿Estás seguro de que deseas eliminar este ticket?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Eliminar"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          try {
                            await firestoreService.deleteTicketAvion(ticket.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Ticket eliminado con éxito")),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("Error al eliminar ticket: $e")),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
