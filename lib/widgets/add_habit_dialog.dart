import 'package:flutter/material.dart';

class AddHabitDialog extends StatelessWidget {
  final Function(String) onAdd;

  const AddHabitDialog({
    super.key,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text('Yeni Alışkanlık Ekle'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Alışkanlık adı'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onAdd(controller.text);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Ekle'),
        ),
      ],
    );
  }
}
