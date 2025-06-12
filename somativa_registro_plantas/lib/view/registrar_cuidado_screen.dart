import 'package:flutter/material.dart';
import '../controllers/cuidado_controller.dart';
import '../models/cuidado.dart';

class RegistrarCuidadoScreen extends StatefulWidget {
  final int plantaId;
  const RegistrarCuidadoScreen({Key? key, required this.plantaId}) : super(key: key);

  @override
  State<RegistrarCuidadoScreen> createState() => _RegistrarCuidadoScreenState();
}

class _RegistrarCuidadoScreenState extends State<RegistrarCuidadoScreen> {
  String tipoSelecionado = 'rega';
  final _obsController = TextEditingController();

  final Color verdeClaro = const Color(0xFFA8E6CF);
  final Color rosaClaro = const Color(0xFFFFD1DC);
  final Color amareloClaro = const Color(0xFFFFF9C4);

  Future<void> _salvar() async {
    final cuidado = Cuidado(
      plantaId: widget.plantaId,
      tipo: tipoSelecionado,
      data: DateTime.now(),
      observacoes: _obsController.text,
    );
    await CuidadoController().inserirCuidado(cuidado);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Cuidado'),
        backgroundColor: verdeClaro,
        elevation: 0,
      ),
      body: Container(
        color: verdeClaro.withOpacity(0.3),
        child: Center(
          child: Card(
            color: amareloClaro.withOpacity(0.8),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: tipoSelecionado,
                    items: const [
                      DropdownMenuItem(value: 'rega', child: Text('Rega')),
                      DropdownMenuItem(value: 'adubação', child: Text('Adubação')),
                      DropdownMenuItem(value: 'poda', child: Text('Poda')),
                      DropdownMenuItem(value: 'outro', child: Text('Outro')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        tipoSelecionado = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Tipo de cuidado',
                      filled: true,
                      fillColor: rosaClaro.withOpacity(0.3),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _obsController,
                    decoration: InputDecoration(
                      labelText: 'Observações',
                      filled: true,
                      fillColor: rosaClaro.withOpacity(0.3),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: rosaClaro,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _salvar,
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

