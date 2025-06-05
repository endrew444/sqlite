import 'dart:io';
import 'package:flutter/material.dart';
import 'package:somativa_registro_plantas/db/databse_helper.dart';
import 'package:somativa_registro_plantas/models/plantas_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Planta> plantas = [];

  @override
  void initState() {
    super.initState();
    _loadPlantas();
  }

  Future<void> _loadPlantas() async {
    final list = await DatabaseHelper.instance.getPlantas();
    setState(() {
      plantas = list;
    });
  }

  void _navigateToCadastro() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroPlantaScreen()),
    );
    if (result == true) {
      _loadPlantas();
    }
  }

  void _navigateToFicha(Planta planta) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FichaPlantaScreen(planta: planta)),
    );
    _loadPlantas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jardim Virtual'),
      ),
      body: plantas.isEmpty
          ? const Center(child: Text('Nenhuma planta cadastrada'))
          : ListView.builder(
              itemCount: plantas.length,
              itemBuilder: (context, index) {
                final planta = plantas[index];
                return ListTile(
                  leading: planta.fotoPath != null
                      ? Image.file(
                          File(planta.fotoPath!),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.local_florist),
                  title: Text(planta.nome),
                  subtitle: Text(planta.especie),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _navigateToFicha(planta),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FichaPlantaScreen extends StatelessWidget {
  final Planta planta;

  const FichaPlantaScreen({Key? key, required this.planta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planta.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            planta.fotoPath != null
                ? Image.file(
                    File(planta.fotoPath!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.local_florist, size: 100),
            const SizedBox(height: 16),
            Text('Espécie: ${planta.especie}', style: const TextStyle(fontSize: 18)),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}

class CadastroPlantaScreen extends StatelessWidget {
  const CadastroPlantaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the UI for plant registration here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Planta'),
      ),
      body: const Center(
        child: Text('Tela de cadastro de planta'),
      ),
    );
  }
}
