import 'package:flutter/material.dart';

import 'about/screen.dart';
import 'common/index.dart';
import 'contacts/screen.dart';
import 'home/screen.dart';
import 'settings/screen.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  final _tabsController = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _tabsController,
      builder: (context, index, child) => AdaptiveScaffold(
        tabs: [
          TabItem(
            title: 'Home',
            iconData: Icons.home,
            body: HomeScreen(),
          ),
          TabItem(
            title: 'About',
            iconData: Icons.info,
            body: AboutScreen(),
          ),
          TabItem(
            title: 'Contacts',
            iconData: Icons.contacts,
            body: ContactsScreen(),
          ),
          TabItem(
            title: 'Settings',
            iconData: Icons.settings,
            body: SettingsScreen(),
          ),
        ],
        selectedIndex: index,
        onSelectionChanged: (val) => _tabsController.value = val,
      ),
    );
  }
}
