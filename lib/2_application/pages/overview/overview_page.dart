import 'package:flutter/material.dart';
import 'package:todo_list_app/2_application/core/page_config.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageconfig = PageConfig(
    icon: Icons.history_edu_outlined,
    name: 'overview',
    child: OverviewPage(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.tealAccent);
  }
}
