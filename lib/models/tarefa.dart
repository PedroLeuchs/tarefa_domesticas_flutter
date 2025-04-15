class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({required this.titulo, this.concluida = false});

  Map<String, dynamic> toMap() {
    return {'titulo': titulo, 'concluida': concluida};
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      titulo: map['titulo'],
      concluida: map['concluida'],
    );
  }
}
