import 'package:flutter/material.dart';

class TodoEntryItemLoading extends StatelessWidget {
  const TodoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
