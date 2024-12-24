class Habit {
  final int id;
  final String name;
  final int daysCompleted;

  Habit({
    required this.id,
    required this.name,
    required this.daysCompleted,
  });

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] as int,
      name: map['name'] as String,
      daysCompleted: map['daysCompleted'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'daysCompleted': daysCompleted,
    };
  }
}
