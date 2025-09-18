import 'package:flutter/material.dart';
import 'worker.dart';  

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Trabajadores',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Registro de Trabajadores'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Worker> workers = [];
  TextEditingController _txtIdCtrl = TextEditingController();
  TextEditingController _txtNombreCtrl = TextEditingController();
  TextEditingController _txtApellidosCtrl = TextEditingController();
  TextEditingController _txtEdadCtrl = TextEditingController();

  void _addWorker() {
    final id = _txtIdCtrl.text.trim();
    final nombre = _txtNombreCtrl.text.trim();
    final apellidos = _txtApellidosCtrl.text.trim();
    final edadStr = _txtEdadCtrl.text.trim();
    
    // Validación de campos
    if (id.isEmpty || nombre.isEmpty || apellidos.isEmpty || edadStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Por favor complete todos los campos")));
      return;
    }

    // Validación de edad (solo mayores de edad)
    final edad = int.tryParse(edadStr);
    if (edad == null || edad < 18) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Debe ser mayor de edad")));
      return;
    }

    // Validación de ID único
    if (workers.any((worker) => worker.id == id)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("El ID ya está registrado")));
      return;
    }

    setState(() {
      workers.add(Worker(id: id, nombre: nombre, apellidos: apellidos, edad: edad));
    });

    // Limpiar los campos
    _txtIdCtrl.clear();
    _txtNombreCtrl.clear();
    _txtApellidosCtrl.clear();
    _txtEdadCtrl.clear();
  }

  void _removeLastWorker() {
    setState(() {
      if (workers.isNotEmpty) {
        workers.removeLast();
      }
    });
  }

  Widget getWorkers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 14),
        Text("Lista de Trabajadores: "),
        SizedBox(height: 10),
        ...workers.map((worker) => Text("- ${worker.nombre} ${worker.apellidos}, ID: ${worker.id}, Edad: ${worker.edad}")).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getWorkers(),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _txtIdCtrl,
                  decoration: InputDecoration(labelText: "ID", border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _txtNombreCtrl,
                  decoration: InputDecoration(labelText: "Nombre", border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _txtApellidosCtrl,
                  decoration: InputDecoration(labelText: "Apellidos", border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _txtEdadCtrl,
                  decoration: InputDecoration(labelText: "Edad", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: _addWorker,
                  child: Text("Agregar Trabajador"),
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: _removeLastWorker,
                  child: Text("Eliminar Último Trabajador"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
