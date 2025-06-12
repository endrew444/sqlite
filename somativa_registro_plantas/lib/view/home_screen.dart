import 'package:flutter/material.dart';
import '../controllers/planta_controller.dart';
import '../models/planta.dart';
import 'cadastro_planta_screen.dart';
import 'ficha_planta_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Planta>> _plantasFuture;

  final Color verdeClaro = const Color(0xFFA8E6CF);
  final Color rosaClaro = const Color(0xFFFFD1DC);
  final Color amareloClaro = const Color(0xFFFFF9C4);

  @override
  void initState() {
    super.initState();
    _plantasFuture = PlantaController().listarPlantas();
  }

  void _atualizarLista() {
    setState(() {
      _plantasFuture = PlantaController().listarPlantas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Plantas'),
        backgroundColor: verdeClaro,
        elevation: 0,
      ),
      // Fundo sólido verde claro
      body: Container(
        // ignore: deprecated_member_use
        color: verdeClaro.withOpacity(0.3),
        child: FutureBuilder<List<Planta>>(
          future: _plantasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar plantas'));
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma planta cadastrada'));
            }

            final plantas = snapshot.data!;
            return ListView.builder(
              itemCount: plantas.length,
              itemBuilder: (context, index) {
                final planta = plantas[index];
                // Alterna as cores dos cards
                final cardColor = index % 3 == 0
                    // ignore: deprecated_member_use
                    ? verdeClaro.withOpacity(0.7)
                    : index % 3 == 1
                        // ignore: deprecated_member_use
                        ? rosaClaro.withOpacity(0.7)
                        // ignore: deprecated_member_use
                        : amareloClaro.withOpacity(0.7);
                return Card(
                  color: cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: const Icon(Icons.local_florist, color: Colors.green, size: 36),
                    title: Text(
                      planta.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      planta.especie,
                      style: const TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: Colors.green),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FichaPlantaScreen(planta: planta),
                      ),
                    ).then((_) => _atualizarLista()),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: rosaClaro,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CadastroPlantaScreen()),
        ).then((_) => _atualizarLista()),
        child: const Icon(Icons.add, color: Colors.green),
        tooltip: 'Adicionar Planta',
      ),
    );
  }
}
