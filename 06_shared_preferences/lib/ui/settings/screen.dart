import 'package:flutter/material.dart';
import 'package:my_project/generated/i18n.dart';
import 'package:my_project/src/classes/settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _settings = Provider.of<Settings>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(I18n.of(context).settingsTitle),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(I18n.of(context).settingsDarkMode),
            value: _settings.isDark,
            onChanged: _settings.updateIsDark,
          )
        ],
      ),
    );
  }
}
