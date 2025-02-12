import 'package:flutter/material.dart';
import '../models/gasto.dart';

class AddGastoDialog extends StatefulWidget {
  @override
  _AddGastoDialogState createState() => _AddGastoDialogState();
}

class _AddGastoDialogState extends State<AddGastoDialog> {
  final _descripcionController = TextEditingController();
  final _precioController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Agregar Gasto"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _descripcionController,
            decoration: InputDecoration(labelText: "Descripción"),
          ),
          TextField(
            controller: _precioController,
            decoration: InputDecoration(labelText: "Precio"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          Text("Fecha: ${_fechaSeleccionada.toLocal()}"),
          ElevatedButton(
            onPressed: () => _seleccionarFecha(context),
            child: Text("Seleccionar Fecha"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_descripcionController.text.isEmpty ||
                _precioController.text.isEmpty) return;

            final nuevoGasto = Gasto(
              descripcion: _descripcionController.text,
              precio: double.parse(_precioController.text),
              fecha: _fechaSeleccionada,
            );

            Navigator.of(context).pop(nuevoGasto);
          },
          child: Text("Agregar"),
        ),
      ],
    );
  }
}