import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/blog/BlogPage.dart';
import 'package:flutter_apps/screens/SignInPage.dart';
import 'package:flutter_apps/screens/debug/PlaygroundScreen.dart';
import 'package:flutter_apps/screens/externalTools/ExternalToolsPage.dart';
import 'package:flutter_apps/screens/guide/GuidePage.dart';
import 'package:flutter_apps/screens/lunch/LunchOverviewPage.dart';
import 'package:flutter_apps/screens/settings/SettingsScreen.dart';
import 'package:flutter_apps/screens/vacation/VacationEmployeeDetail.dart';
import 'package:flutter_apps/screens/vacation/VacationEmployeesOverview.dart';
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
        _header(context),
        ListTile(title: const Text("Home"), visualDensity: VisualDensity.compact, onTap: () => navigateToPage(context, const BlogPage(), removeStash: true)),
        ExpansionTile(
          title: const Text("Vacation App"),
          iconColor: Theme.of(context).colorScheme.onBackground,
          collapsedIconColor: Theme.of(context).colorScheme.onBackground,
          textColor: Theme.of(context).colorScheme.onBackground,
          children: [
            ListTile(
                title: const Text("Employees Overview"),
                visualDensity: VisualDensity.compact,
                onTap: () => navigateToPage(context, const VacationEmployeesOverviewPage(), removeStash: true)),
            ListTile(
                title: const Text("Personal Page"),
                visualDensity: VisualDensity.compact,
                onTap: () => navigateToPage(context, VacationEmployeeDetailPage(email: GoogleService().getAccount().email), removeStash: true))
          ],
        ),
        ListTile(
          title: const Text("Lunch App"),
          visualDensity: VisualDensity.compact,
          onTap: () => navigateToPage(context, const LunchOverviewPage(), removeStash: true),
        ),
        ExpansionTile(
          title: const Text("Guides"),
          iconColor: Theme.of(context).colorScheme.onBackground,
          collapsedIconColor: Theme.of(context).colorScheme.onBackground,
          textColor: Theme.of(context).colorScheme.onBackground,
          children: [
            ListTile(
                title: const Text("First Day guide"),
                visualDensity: VisualDensity.compact,
                onTap: () => navigateToPage(
                      context,
                      const GuidePage(
                        guideId: 'first_day_guide',
                      ),
                      removeStash: true,
                    )),
            ListTile(
                title: const Text("Last Day guide"),
                visualDensity: VisualDensity.compact,
                onTap: () => navigateToPage(
                      context,
                      const GuidePage(
                        guideId: 'last_day_guide',
                      ),
                      removeStash: true,
                    )),
          ],
        ),
        ListTile(title: const Text("External Tools"), onTap: () => navigateToPage(context, const ExternalToolsPage(), removeStash: true)),
        if (kDebugMode)
          ListTile(
            title: const Text("Debug"),
            onTap: () => navigateToPage(context, const PlaygroundScreen()),
          )
      ],
    ));
  }

  Widget _header(BuildContext context) {
    const expandablePanelTheme = ExpandableThemeData(tapHeaderToExpand: true, hasIcon: false, iconColor: Colors.white);

    return ExpandablePanel(
        header: Container(
          height: 160,
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SvgPicture.asset("lib/static/logo-lunatech-black.svg", height: 70, width: 70),
              ),
              ListTile(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(GoogleService().getAccount().displayName ?? GoogleService().getAccount().email, style: const TextStyle(color: Colors.white)),
                  ExpandableIcon(theme: expandablePanelTheme)
                ],
              ))
            ],
          ),
        ),
        collapsed: const Divider(),
        expanded: ListView(shrinkWrap: true, children: [
          ListTile(
              title: const Text("Settings"),
              visualDensity: VisualDensity.compact,
              onTap: () => navigateToPage(context, const SettingsScreen(), removeStash: true)),
          ListTile(title: const Text("Sign Out"), visualDensity: VisualDensity.compact, onTap: () => _logout(context)),
          const Divider()
        ]),
        theme: expandablePanelTheme);
  }

  _logout(BuildContext context) {
    GoogleService().signOut().then((_) {
      VacationAppService.logout();
      WifiAppService.logout();
      navigateToPage(context, const SignInPage(), removeStash: true);
    });
  }
}
