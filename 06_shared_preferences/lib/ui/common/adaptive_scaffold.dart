import 'package:flutter/material.dart';

import 'constants.dart';

class AdaptiveScaffold extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelectionChanged;

  const AdaptiveScaffold({
    Key key,
    @required this.tabs,
    @required this.selectedIndex,
    @required this.onSelectionChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, dimens) {
      if (dimens.maxWidth >= kDesktopBreakpoint) {
        final _tabs = <Widget>[];
        for (var i = 0; i < tabs.length; i++) {
          _tabs.add(ListTile(
            selected: selectedIndex == i,
            title: Text(tabs[i].title),
            leading: Icon(tabs[i].iconData),
            onTap: () => onSelectionChanged(i),
          ));
        }
        return Material(
          child: Row(
            children: [
              Container(
                width: kSideMenuWidth,
                child: ListView(children: _tabs),
              ),
              VerticalDivider(width: 0),
              Expanded(
                child: buildBody(selectedIndex, tabs),
              ),
            ],
          ),
        );
      }
      if (dimens.maxWidth >= kTabletBreakpoint) {
        final _destinations = <NavigationRailDestination>[];
        for (final item in tabs) {
          _destinations.add(NavigationRailDestination(
            label: Text(item.title),
            icon: Icon(item.iconData),
          ));
        }
        return Material(
          child: Row(
            children: [
              NavigationRail(
                selectedIconTheme: IconThemeData(
                  color: Theme.of(context).accentColor,
                ),
                selectedLabelTextStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
                unselectedIconTheme: IconThemeData(
                  color: Colors.grey,
                ),
                labelType: NavigationRailLabelType.all,
                selectedIndex: selectedIndex,
                onDestinationSelected: (val) => onSelectionChanged(val),
                destinations: _destinations,
              ),
              Expanded(
                child: buildBody(selectedIndex, tabs),
              ),
            ],
          ),
        );
      }
      final _tabs = <BottomNavigationBarItem>[];
      for (final item in tabs) {
        _tabs.add(BottomNavigationBarItem(
          title: Text(item.title),
          icon: Icon(item.iconData),
        ));
      }
      return Scaffold(
        body: buildBody(selectedIndex, tabs),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (val) => onSelectionChanged(val),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: _tabs,
        ),
      );
    });
  }

  Widget buildBody(int selectedIndex, List<TabItem> tabs) {
    final _children = <Widget>[];
    for (final item in tabs) {
      _children.add(item.body);
    }
    return IndexedStack(
      index: selectedIndex,
      children: _children,
    );
  }
}

class TabItem {
  final Widget body;
  final String title;
  final IconData iconData;

  TabItem({
    @required this.body,
    @required this.title,
    @required this.iconData,
  });
}
