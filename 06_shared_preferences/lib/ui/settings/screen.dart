import 'package:flutter/material.dart';
import 'package:my_project/src/classes/settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _settings = Provider.of<Settings>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _settings.isDark,
            onChanged: _settings.updateIsDark,
          )
        ],
      ),
    );
  }
}
