import 'package:flutter/material.dart';
import 'package:todo_list_app/2_application/core/page_config.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  static const pageconfig = PageConfig(
    icon: Icons.task_alt_rounded,
    name: 'tasks',
    child: TaskPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
