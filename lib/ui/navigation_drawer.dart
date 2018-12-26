import 'package:flutter/material.dart';
import 'package:flutter_multi_page_drawer/main.dart';

typedef bool OnNavigationItemSelect(int index);

typedef Widget NavigationRowItemBuilder(BuildContext context, DrawerItem item);

class NavigationDrawer extends StatelessWidget {
  final int selectedIndex;
  final List<DrawerItem> drawerItems;
  final OnNavigationItemSelect onNavigationItemSelect;

  // final NavigationRowItemBuilder navigationRowItemBuilder;
  final Widget headerView;

  const NavigationDrawer(
      {Key key, this.drawerItems, this.onNavigationItemSelect, this.headerView, this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
    List<Widget> drawerOptions = [];
    drawerOptions.add(headerView);
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(
          d.title,
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        selected: i == selectedIndex,
        onTap: () {
          if(onNavigationItemSelect(i)){
            state.close();
          }

        },
      ));
    }

    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: drawerOptions),
    );
  }
}


class DrawerItem {
  final String title;
  final IconData icon;

  DrawerItem(this.title, this.icon);
}
