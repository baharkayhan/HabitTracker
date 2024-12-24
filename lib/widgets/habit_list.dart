import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habits;
  final Function(int, int) onIncrementDay;

  const HabitList({
    super.key,
    required this.habits,
    required this.onIncrementDay,
  });

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return const Center(
        child: Text(
          'Henüz alışkanlık eklenmedi!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        return ListTile(
          title: Text(habit.name),
          subtitle: Text('Tamamlanan Gün: ${habit.daysCompleted}'),
          trailing: IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.pink),
            onPressed: () => onIncrementDay(habit.id, habit.daysCompleted),
          ),
        );
      },
    );
  }
}
