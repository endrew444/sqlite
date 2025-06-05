import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somativa_registro_plantas/db/databse_helper.dart';
import 'package:somativa_registro_plantas/models/plantas_model.dart';
import '../db/database_helper.dart';
import '../models/planta.dart';

class CadastroPlantaScreen extends StatefulWidget {
  const CadastroPlantaScreen({super.key});

  @override
  State<CadastroPlantaScreen> createState() => _CadastroPlantaScreenState();
}

class _CadastroPlantaScreenState extends State<CadastroPlantaScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _especieController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  DateTime? _dataAquisicao;
  File? _imagem;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final File? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (image != null) {
      setState(() {
        _imagem = File(image.path);
      });
    }
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataAquisicao ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _dataAquisicao = picked;
      });
    }
  }

  Future<void> _savePlanta() async {
    if (!_formKey.currentState!.validate() || _dataAquisicao == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente')),
      );
      return;
    }

    final planta = Planta(
      nome: _nomeController.text.trim(),
      especie: _especieController.text.trim(),
      dataAquisicao: _dataAquisicao!,
      local: _localController.text.trim(),
      fotoPath: _imagem?.path,
    );

    await DatabaseHelper.instance.insertPlanta(planta);
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _especieController.dispose();
    _localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Planta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imagem == null
                    ? Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.add_a_photo, size: 50),
                      )
                    : Image.file(_imagem!, height: 150, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da planta'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _especieController,
                decoration: const InputDecoration(labelText: 'Espécie'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a espécie' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(labelText: 'Local'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o local' : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Data de aquisição'),
                subtitle: Text(_dataAquisicao == null
                    ? 'Nenhuma data selecionada'
                    : '${_dataAquisicao!.day}/${_dataAquisicao!.month}/${_dataAquisicao!.year}'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePlanta,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePicker {
  Future<File?> pickImage({required source, required int imageQuality}) async {}
}

class ImageSource {
  static var gallery;
}
