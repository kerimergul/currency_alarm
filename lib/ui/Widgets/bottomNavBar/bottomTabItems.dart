import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Homepage, Alarms, Currency, Settings }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.Homepage: TabItemData("Homepage", Icons.home),
    TabItem.Alarms: TabItemData("Alarms", Icons.alarm),
    TabItem.Currency: TabItemData("Currency", Icons.euro_symbol),
    TabItem.Settings: TabItemData("Settings", Icons.people),
  };
}
