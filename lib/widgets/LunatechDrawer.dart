import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/HomePage.dart';
import 'package:flutter_apps/screens/SignInPage.dart';
import 'package:flutter_apps/screens/vacation/EmployeeOverviewPage.dart';
import 'package:flutter_apps/screens/wifi/WifiResetPage.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/services/WifiAppService.dart';

import '../util/UtilMethods.dart';

class LunatechDrawer extends StatelessWidget {
  const LunatechDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(child: Text("Menu")),
        ListTile(
            title: const Text("Home"),
            visualDensity: VisualDensity.compact,
            onTap: () =>
                navigateToPage(context, const HomePage(), removeStash: true)),
        ListTile(
            title: const Text("Vacation App"),
            visualDensity: VisualDensity.compact,
            onTap: () => navigateToPage(context, const EmployeeOverviewPage(),
                removeStash: true)),
        const ListTile(
          title: Text("Lunch App"),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
            title: const Text("Wifi Reset"),
            visualDensity: VisualDensity.compact,
            onTap: () => navigateToPage(context, const WifiResetPage(),
                removeStash: true)),
        ListTile(
            title: const Text("Sign Out"),
            visualDensity: VisualDensity.compact,
            onTap: () => _logout(context))
      ],
    ));
  }

  _logout(BuildContext context) {
    VacationAppService().logout();
    WifiAppService().logout();

    GoogleService()
        .signOut()
        .then((_) => navigateToPage(context, const SignInPage()));
  }
}
