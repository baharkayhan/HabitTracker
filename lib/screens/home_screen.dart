import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/habit.dart';
import '../widgets/habit_list.dart';
import '../widgets/add_habit_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  List<Habit> _habits = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _databaseService.initialize();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habits = await _databaseService.getHabits();
    setState(() {
      _habits = habits;
    });
  }

  Future<void> _addHabit(String name) async {
    await _databaseService.addHabit(name);
    _loadHabits();
  }

  Future<void> _incrementDay(int id, int currentDays) async {
    await _databaseService.incrementDay(id, currentDays);
    _loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Günlük Alışkanlıklar'),
      ),
      body: HabitList(
        habits: _habits,
        onIncrementDay: _incrementDay,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddHabitDialog(onAdd: _addHabit),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _databaseService.dispose();
    super.dispose();
  }
}
