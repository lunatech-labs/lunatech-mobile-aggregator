import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/blog/BlogPage.dart';
import 'package:flutter_apps/screens/SignInPage.dart';
import 'package:flutter_apps/screens/settings/SettingsScreen.dart';
import 'package:flutter_apps/screens/vacation/VacationEmployeeDetail.dart';
import 'package:flutter_apps/screens/vacation/VacationEmployeesOverview.dart';
import 'package:flutter_apps/screens/wifi/WifiResetPage.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/VacationAppService.dart';
import 'package:flutter_apps/services/WifiAppService.dart';
import 'package:flutter_svg/svg.dart';

import '../util/UtilMethods.dart';

class LunatechDrawer extends StatelessWidget {
  const LunatechDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        _header2(context),
        ListTile(
            title: const Text("Home"),
            visualDensity: VisualDensity.compact,
            onTap: () =>
                navigateToPage(context, const BlogPage(), removeStash: true)),
        ExpansionTile(
          title: const Text("Vacation App"),
          children: [
            ListTile(
                title: const Text("Employees Overview"),
                visualDensity: VisualDensity.compact,
                onTap: () => navigateToPage(
                    context, const EmployeeOverviewPage(),
                    removeStash: true)),
            ListTile(
                title: const Text("Personal Page"),
                visualDensity: VisualDensity.compact,
                onTap: () => navigateToPage(
                    context,
                    EmployeeDetailPage(
                        email: GoogleService().getAccount().email),
                    removeStash: true))
          ],
        ),
        const ListTile(
          title: Text("Lunch App"),
          visualDensity: VisualDensity.compact,
        ),
        ListTile(
            title: const Text("Wifi Reset"),
            visualDensity: VisualDensity.compact,
            onTap: () => navigateToPage(context, const WifiResetPage(),
                removeStash: true))
      ],
    ));
  }

  Widget _header2(BuildContext context) {
    const expandablePanelTheme =
        ExpandableThemeData(tapHeaderToExpand: true, hasIcon: false, iconColor: Colors.white);

    return ExpandablePanel(
        header: Container(
          height: 160,
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SvgPicture.asset("lib/static/logo-lunatech.svg",
                    height: 70, width: 70),
              ),
              ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(GoogleService().getAccount().displayName!,
                      style: const TextStyle(color: Colors.white)),
                  ExpandableIcon(theme: expandablePanelTheme)
                ],
              ))
            ],
          ),
        ),
        collapsed: const Divider(),
        expanded: ListView(
          shrinkWrap: true,
            children: [
          ListTile(
              title: const Text("Settings"),
              visualDensity: VisualDensity.compact,
              onTap: () => navigateToPage(context, const SettingsScreen(), removeStash: true)),
          ListTile(
              title: const Text("Sign Out"),
              visualDensity: VisualDensity.compact,
              onTap: () => _logout(context)),
          const Divider()
        ]),
        theme: expandablePanelTheme);
  }

  _logout(BuildContext context) {
    GoogleService().signOut().then((_) {
      VacationAppService.logout();
      WifiAppService.logout();
      navigateToPage(context, const SignInPage());
    });
  }
}
