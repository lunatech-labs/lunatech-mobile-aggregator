import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/services/WifiAppService.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechDrawer.dart';

import '../../widgets/LunatechLoading.dart';

class WifiResetPage extends StatefulWidget {
  const WifiResetPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WifiResetState();
  }
}

class _WifiResetState extends State<WifiResetPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const LunatechLoading()
        : Scaffold(
            appBar: AppBar(title: const Text("Wifi Reset")),
            drawer: const LunatechDrawer(),
            body: _body(),
          );
  }

  Widget _body() {
    return LunatechBackground(
        child: SizedBox.expand(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.7,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_description(), _generateNewPasswordButton()]),
          ),
        ),
      ),
    ));
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text("Wifi Password Generation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
              "By clicking the button below you will trigger the generation of a "
              "new password for the LunatechEnterprise network. All the devices "
              "that are using the current one will have to migrate to the new one.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15
              )
            )
          )
        ]
      )
    );
  }

  Widget _generateNewPasswordButton() {
    return GestureDetector(
        onTap: () => _showConfirmationDialog(),
        child: Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const FractionallySizedBox(
                widthFactor: 0.8,
                child: Text("Generate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)))));
  }

  _showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text(
                  "You'll have to change password to all your devices"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Siuu"))
              ],
            )).then((response) {
      if (response) _generatePassword();
    });
  }

  _generatePassword() async {
    setState(() => _loading = true);
    String newPassword = await WifiAppService().generateWifiPassword();
    setState(() => _loading = false);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("New Password"),
              content: SelectableText(newPassword),
              actions: [
                TextButton(
                    onPressed: () => _copyToClipboard(newPassword),
                    child: const Text("Copy to Clipboard")),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"))
              ],
            ));
  }

  _copyToClipboard(String newPassword) {
    Clipboard.setData(ClipboardData(text: newPassword));
  }
}
