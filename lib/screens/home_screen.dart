import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../services/tarefa_service.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tarefa> tarefas = [];
  final service = TarefaService();

  @override
  void initState() {
    super.initState();
    carregar();
  }

  void carregar() async {
    final data = await service.carregarTarefas();
    setState(() {
      tarefas = data;
    });
  }

  void atualizar() async {
    await service.salvarTarefas(tarefas);
    setState(() {});
  }

  void adicionarTarefa(String titulo) {
    setState(() {
      tarefas.add(Tarefa(titulo: titulo));
    });
    atualizar();
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
    atualizar();
  }

  void toggleConclusao(int index) {
    setState(() {
      tarefas[index].concluida = !tarefas[index].concluida;
    });
    atualizar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas Domésticas')),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          final tarefa = tarefas[index];
          return ListTile(
            title: Text(
              tarefa.titulo,
              style: TextStyle(
                decoration: tarefa.concluida
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: tarefa.concluida,
              onChanged: (_) => toggleConclusao(index),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => removerTarefa(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final titulo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
          if (titulo != null && titulo is String) {
            adicionarTarefa(titulo);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
