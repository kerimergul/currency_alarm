import 'package:currency_alarm/ui/Widgets/bottomNavBar/bottomTabItems.dart';
import 'package:currency_alarm/ui/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.pageBuilder})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> pageBuilder;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: bgColor,
      tabBar: CupertinoTabBar(
        items: [
          _navItemCreate(TabItem.Homepage),
          _navItemCreate(TabItem.Alarms),
          _navItemCreate(TabItem.Currency),
          _navItemCreate(TabItem.Settings),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final showItem = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) => pageBuilder[showItem],
        );
      },
    );
  }

  BottomNavigationBarItem _navItemCreate(TabItem tabItem) {
    final nextTab = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      icon: Container(
        width: 400,
        height: 40,
        child: Icon(
          nextTab.icon,
          size: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
      activeIcon: Container(
        width: 400,
        height: 40,
        child: Icon(
          nextTab.icon,
          size: 25,
          color: bgColor,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }
}
