import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final controller = TextEditingController();

  void salvar() {
    final texto = controller.text.trim();
    if (texto.isNotEmpty) {
      Navigator.pop(context, texto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Título da tarefa'),
              onSubmitted: (_) => salvar(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvar,
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
