import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/gasto.dart';
import '../widgets/add_gasto_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Gasto> gastos = [];

  void _agregarGasto(Gasto nuevoGasto) {
    setState(() {
      gastos.add(nuevoGasto);
    });
  }

  void _eliminarGasto(int index) {
    setState(() {
      gastos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Gastos')),
      body: gastos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/empty.png', height: 100),
                  Text("No hay gastos registrados"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _eliminarGasto(index),
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Borrar',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(gastos[index].descripcion),
                    subtitle: Text("${gastos[index].fecha.toLocal()}"),
                    trailing: Text("S/ ${gastos[index].precio.toStringAsFixed(2)}"),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoGasto = await showDialog<Gasto>(
            context: context,
            builder: (context) => AddGastoDialog(),
          );
          if (nuevoGasto != null) _agregarGasto(nuevoGasto);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
