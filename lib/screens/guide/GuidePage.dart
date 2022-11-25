import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/model/guide/Guide.dart';
import 'package:flutter_apps/model/guide/GuideItem.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechDrawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class GuidePage extends StatefulWidget{
  GuidePage({super.key, required this.guideId});

  String guideId;

  @override
  State<StatefulWidget> createState() => GuidePageState();

}

class GuidePageState extends State<GuidePage> {
  
  late Guide guide;
  bool isLoading = true;


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/data/${widget.guideId}.json');
    final data = await json.decode(response);
    Guide tmp = Guide.fromJson(data);
    final prefs = await SharedPreferences.getInstance();
    List<String> selectedIds = prefs.getStringList(widget.guideId) ?? [];
    for (var id in selectedIds) {tmp.items[id]?.done = true;}
    setState(() {
      guide = tmp;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return _loading();
    }
    return _body();
  }

  Scaffold _loading() {
    return const Scaffold(
        drawer: LunatechDrawer(),
    );
  }

  Scaffold _body() {
    return Scaffold(
      appBar: AppBar(title: Text(guide.name)),
      drawer: const LunatechDrawer(),
      body: ListView.builder(
          itemCount: guide.items.length,
          itemBuilder: (context, index) => _guideListBuilder(guide.items[index + 1]!))
    );
  }

  Widget _guideListBuilder(GuideItem guideItem) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
              checkColor: secondaryColor,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: secondaryColor, width: 1)),
              value: guideItem?.done , onChanged: (bool? value) {
                setState(() {
                  guideItem.done = true;
                });
                saveGuideItem(guideItem);
          }),
          Expanded(
            child: Column(
              children: [
                Text(guideItem.title),
                Text(guideItem.detail)
              ],
            ),
          )
        ],
      ),
    );
  }

  _handleOnclick() {
    // TODO
  }

  void saveGuideItem(GuideItem item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList(widget.guideId) ?? [];
    if(item.done) {
      ids.add(item.id.toString());
    } else {
      ids.remove(item.id.toString());
    }
    prefs.setStringList(widget.guideId, ids);
  }

}

