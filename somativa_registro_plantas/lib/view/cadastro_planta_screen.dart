import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/planta_controller.dart';

class CadastroPlantaScreen extends StatefulWidget {
  const CadastroPlantaScreen({super.key});

  @override
  State<CadastroPlantaScreen> createState() => _CadastroPlantaScreenState();
}

class _CadastroPlantaScreenState extends State<CadastroPlantaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = PlantaController();

  final _nomeController = TextEditingController();
  final _especieController = TextEditingController();
  final _dataController = TextEditingController();
  final _localController = TextEditingController();

  File? _imagem;
  final ImagePicker _picker = ImagePicker();

  final Color verdeClaro = const Color(0xFFA8E6CF);
  final Color rosaClaro = const Color(0xFFFFD1DC);

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      await _controller.adicionarPlanta(
        nome: _nomeController.text,
        especie: _especieController.text,
        data: _dataController.text,
        local: _localController.text,
        fotoPath: _imagem?.path, // <-- adicione isso
      );
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Planta"),
        backgroundColor: verdeClaro,
        elevation: 0,
      ),
      body: Container(
        color: verdeClaro.withOpacity(0.15),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imagem == null
                    ? Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: verdeClaro.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.add_a_photo, size: 50, color: Colors.green),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _imagem!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Nome da planta",
                  filled: true,
                  fillColor: rosaClaro.withOpacity(0.2),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _especieController,
                decoration: InputDecoration(
                  labelText: "Espécie",
                  filled: true,
                  fillColor: rosaClaro.withOpacity(0.2),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Informe a espécie' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(
                  labelText: "Data de aquisição",
                  filled: true,
                  fillColor: rosaClaro.withOpacity(0.2),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Informe a data' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _localController,
                decoration: InputDecoration(
                  labelText: "Local",
                  filled: true,
                  fillColor: rosaClaro.withOpacity(0.2),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) => value!.isEmpty ? 'Informe o local' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: rosaClaro,
                    foregroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _salvar,
                  child: const Text("Salvar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}