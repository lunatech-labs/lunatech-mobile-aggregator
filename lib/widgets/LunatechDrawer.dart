import 'package:flutter/material.dart';
import 'package:flutter_apps/screens/HomePage.dart';
import 'package:flutter_apps/screens/SignInPage.dart';
import 'package:flutter_apps/screens/vacation/VacationAppListPage.dart';
import 'package:flutter_apps/services/GoogleService.dart';

class LunatechDrawer extends StatelessWidget {
  const LunatechDrawer({super.key});

  _navigateToPage(BuildContext context, Widget widget){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Menu")),
          ListTile(title: const Text("Home"), visualDensity: VisualDensity.compact, onTap: () => _navigateToPage(context, const HomePage())),
          ListTile(title: const Text("Vacation App"), visualDensity: VisualDensity.compact, onTap: () => _navigateToPage(context, const VacationAppListPage())),
          const ListTile(title: Text("Lunch App"), visualDensity: VisualDensity.compact,),
          ListTile(title: const Text("Sign Out"), visualDensity: VisualDensity.compact, onTap: () =>
            GoogleService().signOut().then((_) => _navigateToPage(context, const SignInPage()))
          )
        ],
      )
    );
  }
}
