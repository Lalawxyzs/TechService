import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _specialController = TextEditingController();

  void _register() {
    if (_nameController.text.isNotEmpty && _specialController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Técnico registrado com sucesso!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Técnico')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Crie o seu perfil profissional para começar a receber ordens de serviço.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                prefixIcon: Icon(Icons.handyman),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _specialController,
              decoration: const InputDecoration(
                labelText: 'Especialidade (Ex: Redes, Hardware, Software)',
                prefixIcon: Icon(Icons.handyman),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Concluir Cadastro',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specialController.dispose();
    super.dispose();
  }
}
