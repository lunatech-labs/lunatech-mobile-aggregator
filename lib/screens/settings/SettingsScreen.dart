import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/model/settings/AppSettings.dart';
import 'package:flutter_apps/services/WifiAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO every tile should probably have its own class, to make the code cleaner
    return LunatechScaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: ListView(
          shrinkWrap: true,
          children: [
            darkModeToggle(),
            generateWifiOption()
          ],
        ));
  }

  ListTile darkModeToggle() {
    return ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: AppSettings().themeMode == ThemeMode.dark,
                onChanged: (value) {
                  AppSettings().setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  setState(() {});
                }));
  }

  ListTile generateWifiOption() {
    return ListTile(
      title: const Text("Generate new Wi-Fi password"),
        trailing: TextButton(
          child: Text("Generate", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          onPressed: () => _showConfirmationDialog(),
        ),
    );
  }

  _showConfirmationDialog() {
    Color accentColor = Theme.of(context).colorScheme.secondary;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Are you sure?",
            style: TextStyle(color: accentColor),
          ),
          content: const Text(
              "You'll have to change password to all your devices"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: accentColor),
                )),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  "Yes",
                  style: TextStyle(color: accentColor),
                ))
          ],
        )).then((response) {
      if (response) _generatePassword();
    });
  }

  _generatePassword() async {
    final loading = showLoadingScreen(context);
    String newPassword = await WifiAppService().generateWifiPassword();
    if (!mounted) return;
    loading.stopLoading(context);

    Color accentColor = Theme.of(context).colorScheme.secondary;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "New Password",
            style: TextStyle(color: accentColor),
          ),
          content: SelectableText(newPassword),
          actions: [
            TextButton(
                onPressed: () => Clipboard.setData(ClipboardData(text: newPassword)),
                child: Text(
                  "Copy to Clipboard",
                  style: TextStyle(color: accentColor),
                )),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(color: accentColor),
                ))
          ],
        ));
  }
}
