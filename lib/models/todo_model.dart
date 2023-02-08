class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  bool done;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.done = false,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? done,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      done: done ?? this.done,
    );
  }
}
