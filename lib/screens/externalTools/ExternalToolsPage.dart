import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_apps/static/externalTools/external_tools.dart';
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
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      childAspectRatio: 0.7,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FractionallySizedBox(
                  widthFactor: 0.65,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.network(externalTool.image))),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(externalTool.name)),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(externalTool.description ?? "",
                      textAlign: TextAlign.center,

                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.70))))
            ],
          ),
        ),
      ),
    );
  }
}
