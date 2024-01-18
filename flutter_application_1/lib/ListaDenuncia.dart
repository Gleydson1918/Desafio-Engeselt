import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ListaDenuncia());
}

class ListaDenuncia extends StatelessWidget {
  const ListaDenuncia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListaDenuncia(),
    );
  }
}

class ListaDenuncia1 extends StatefulWidget {
  const ListaDenuncia1({Key? key}) : super(key: key);

  @override
  _ListaDenunciaState createState() => _ListaDenunciaState();
}

class _ListaDenunciaState extends State<ListaDenuncia1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  int _protocolNumber = 1; // Inicializando o número do protocolo

  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comunique',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey,
                  labelText: 'Nome Completo',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Digite seu nome:',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey,
                  labelText: 'Endereço',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Digite seu Endereço:',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey,
                  labelText: 'Telefone',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Digite seu Telefone:',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                minLines: 5,
                maxLines: 8,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey,
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Digite sua denúncia:',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: _getImage,
                    child: const Text('Anexar Foto',
                        style: TextStyle(color: Colors.blue)),
                  ),
                  _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          width: 20,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String protocol = 'Protocolo$_protocolNumber';
                          _protocolNumber++;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Enviando dados... Número do Protocolo: $protocol'),
                            ),
                          );
                          print('Número do Protocolo: $protocol');
                          print('Nome: ${_nameController.text}');
                          print('Endereço: ${_addressController.text}');
                          print('Telefone: ${_phoneController.text}');
                          print('Descrição: ${_descriptionController.text}');
                        }
                      },
                      child: const Text('Enviar',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
