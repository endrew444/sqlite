import 'dart:io';

import 'package:flutter/material.dart';
import '../controllers/cuidado_controller.dart';
import '../models/planta.dart';
import '../models/cuidado.dart';
import 'registrar_cuidado_screen.dart';

class FichaPlantaScreen extends StatefulWidget {
  final Planta planta;
  const FichaPlantaScreen({Key? key, required this.planta}) : super(key: key);

  @override
  State<FichaPlantaScreen> createState() => _FichaPlantaScreenState();
}

class _FichaPlantaScreenState extends State<FichaPlantaScreen> {
  late Future<List<Cuidado>> _cuidadosFuture;

  final Color verdeClaro = const Color(0xFFA8E6CF);
  final Color rosaClaro = const Color(0xFFFFD1DC);
  final Color amareloClaro = const Color(0xFFFFF9C4);

  @override
  void initState() {
    super.initState();
    _carregarCuidados();
  }

  void _carregarCuidados() {
    _cuidadosFuture = CuidadoController().listarCuidadosPorPlanta(widget.planta.id!);
  }

  Future<void> _irParaRegistrarCuidado() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrarCuidadoScreen(plantaId: widget.planta.id!),
      ),
    );
    setState(() {
      _carregarCuidados(); // Recarrega o histórico ao voltar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planta.nome),
        backgroundColor: verdeClaro,
        elevation: 0,
      ),
      body: Container(
        color: verdeClaro.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FOTO DA PLANTA
            if (widget.planta.fotoPath != null && widget.planta.fotoPath!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(widget.planta.fotoPath!),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: verdeClaro.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.local_florist, size: 60, color: Colors.green),
                  ),
                ),
              ),
            Card(
              color: amareloClaro.withOpacity(0.8),
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Espécie: ${widget.planta.especie}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Local: ${widget.planta.local}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Data de aquisição: ${widget.planta.dataAquisicao}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Histórico de Cuidados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Cuidado>>(
                future: _cuidadosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhum cuidado registrado.'));
                  }
                  final cuidados = snapshot.data!;
                  return ListView.builder(
                    itemCount: cuidados.length,
                    itemBuilder: (context, index) {
                      final cuidado = cuidados[index];
                      final cardColor = index % 2 == 0
                          ? rosaClaro.withOpacity(0.7)
                          : amareloClaro.withOpacity(0.7);
                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.spa, color: Colors.green),
                          title: Text(
                            cuidado.tipo[0].toUpperCase() + cuidado.tipo.substring(1),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${cuidado.data.day}/${cuidado.data.month}/${cuidado.data.year}'
                            '${(cuidado.observacoes != null && cuidado.observacoes!.isNotEmpty) ? '\nObs: ${cuidado.observacoes}' : ''}',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _irParaRegistrarCuidado,
        backgroundColor: rosaClaro,
        child: const Icon(Icons.add, color: Colors.green),
        tooltip: 'Registrar cuidado',
      ),
    );
  }
}
