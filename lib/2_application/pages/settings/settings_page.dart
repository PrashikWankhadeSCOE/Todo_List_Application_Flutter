import 'package:flutter/material.dart';
import 'package:todo_list_app/2_application/core/page_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const pagecondfig = PageConfig(
    icon: Icons.settings_rounded,
    name: 'setting',
    child: SettingsPage(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.pinkAccent);
  }
}
