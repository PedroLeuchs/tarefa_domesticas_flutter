import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tarefa.dart';

class TarefaService {
  static const String key = 'tarefas';

  Future<List<Tarefa>> carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null) {
      List decoded = json.decode(data);
      return decoded.map((e) => Tarefa.fromMap(e)).toList();
    }
    return [];
  }

  Future<void> salvarTarefas(List<Tarefa> tarefas) async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(tarefas.map((t) => t.toMap()).toList());
    await prefs.setString(key, data);
  }
}
