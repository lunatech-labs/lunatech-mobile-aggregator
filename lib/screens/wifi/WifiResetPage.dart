import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/services/WifiAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechDrawer.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

import '../../widgets/LunatechLoading.dart';

class WifiResetPage extends StatefulWidget {
  const WifiResetPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WifiResetState();
  }
}

class _WifiResetState extends State<WifiResetPage> {
  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
      appBar: AppBar(title: const Text("Wifi Reset")),
      body: _body(),
    );
  }

  Widget _body() {
    return SizedBox.expand(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.7,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_description(), _generateNewPasswordButton()]),
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Text("Wifi Password Generation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                  "By clicking the button below you will trigger the generation of a "
                  "new password for the LunatechEnterprise network. All the devices "
                  "that are using the current one will have to migrate to the new one.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15)))
        ]));
  }

  Widget _generateNewPasswordButton() {
    return GestureDetector(
        onTap: () => _showConfirmationDialog(),
        child: Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Text("Generate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500)))));
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
                      "Siuu",
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
                    onPressed: () => _copyToClipboard(newPassword),
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

  _copyToClipboard(String newPassword) {
    Clipboard.setData(ClipboardData(text: newPassword));
  }
}
