import 'package:flutter/material.dart';
import 'package:my_project/ui/about/screen.dart';
import 'package:my_project/ui/breakpoints.dart';
import 'package:my_project/ui/settings/screen.dart';

import 'home/screen.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    const kSideMenuWidth = 250.0;
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth >= kDesktopBreakpoint) {
          return Material(
            child: Row(
              children: [
                Container(
                  width: kSideMenuWidth,
                  child: ListView(
                    children: [
                      ListTile(
                        selected: _currentIndex == 0,
                        title: Text('Home'),
                        leading: Icon(Icons.home),
                        onTap: () => _onTap(0),
                      ),
                      ListTile(
                        selected: _currentIndex == 1,
                        title: Text('About'),
                        leading: Icon(Icons.info_outline),
                        onTap: () => _onTap(1),
                      ),
                      ListTile(
                        selected: _currentIndex == 2,
                        title: Text('Settings'),
                        leading: Icon(Icons.settings),
                        onTap: () => _onTap(2),
                      ),
                    ],
                  ),
                ),
                Expanded(child: buildBody()),
              ],
            ),
          );
        }
        if (dimens.maxWidth >= kTabletBreakpoint) {
          return Material(
            child: Row(
              children: [
                NavigationRail(
                  labelType: NavigationRailLabelType.all   ,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onTap,
                  destinations: [
                    NavigationRailDestination(
                      label: Text('Home'),
                      icon: Icon(Icons.home),
                    ),
                    NavigationRailDestination(
                      label: Text('About'),
                      icon: Icon(Icons.info_outline),
                    ),
                    NavigationRailDestination(
                      label: Text('Settings'),
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
                Expanded(child: buildBody()),
              ],
            ),
          );
        }
        return Scaffold(
          body: buildBody(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onTap,
            items: [
              BottomNavigationBarItem(
                title: Text('Home'),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text('About'),
                icon: Icon(Icons.info_outline),
              ),
              BottomNavigationBarItem(
                title: Text('Settings'),
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onTap(int val) {
    if (mounted)
      setState(() {
        _currentIndex = val;
      });
  }

  IndexedStack buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomeScreen(),
        AboutScreen(),
        SettingsScreen(),
      ],
    );
  }
}
