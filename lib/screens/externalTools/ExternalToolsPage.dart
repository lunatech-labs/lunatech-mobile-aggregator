import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_apps/static/externalTools/externalTools.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExternalToolsPage extends StatelessWidget {
  const ExternalToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
        appBar: AppBar(title: const Text("External Tools")),
        body: body(context));
  }

  Widget body(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(externalTools.length,
          (index) => buildExternalTool(externalTools[index], context)),
    );
  }

  Widget buildExternalTool(
      ExternalToolInfo externalTool, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => launchUrlString(
            Platform.isAndroid ? externalTool.androidUrl : externalTool.iosUrl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
                widthFactor: 0.65, child: Image.network(externalTool.image)),
            Padding(
                padding: const EdgeInsets.all(5),
                child: Text(externalTool.name))
          ],
        ),
      ),
    );
  }
}
