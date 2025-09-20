import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador con Historial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Contador'),
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
  int _counter = 0;

  final List<int> _historial = <int>[];
  bool _mostrarHistorial = false;

  void _registrarEnHistorial() {
  
    setState(() {
      _historial.add(_counter);
    });
  }

  void _incrementar() {
    setState(() => _counter++);
    _registrarEnHistorial();
  }

  void _decrementar() {
    setState(() {
      if (_counter > 0) _counter--;
    });
    _registrarEnHistorial();
  }

  void _toggleMostrarHistorial() {
    setState(() => _mostrarHistorial = !_mostrarHistorial);
  }

  void _limpiarHistorial() {
    setState(() => _historial.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Historial limpiado')),
    );
  }


  Widget _buildHistorial() {
    if (_historial.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "No hay historial todavía.",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      );
    }

  
    return SizedBox(
      height: 220, 
      child: ListView.builder(
        itemCount: _historial.length,
        itemBuilder: (context, index) {
          final valor = _historial[index];
       
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text('Valor: $valor'),
            subtitle: Text('Posición: ${index + 1}'),
            dense: true,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
        
          IconButton(
            tooltip: _mostrarHistorial ? 'Ocultar historial' : 'Mostrar historial',
            icon: Icon(_mostrarHistorial ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleMostrarHistorial,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Has presionado el botón esta cantidad de veces:'),
              const SizedBox(height: 8),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 20),

            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: _limpiarHistorial,
                    icon: const Icon(Icons.cleaning_services),
                    label: const Text('Limpiar historial'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

          
              if (_mostrarHistorial) _buildHistorial(),
            ],
          ),
        ),
      ),

  
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'fab-decrement',
            onPressed: _decrementar,
            tooltip: 'Restar',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            heroTag: 'fab-increment',
            onPressed: _incrementar,
            tooltip: 'Sumar',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}