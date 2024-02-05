import 'package:flutter/material.dart';

class ToDoDetailError extends StatelessWidget {
  const ToDoDetailError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Text('ERROR on Detail Page, Please try again !'),
      ),
    );
  }
}
