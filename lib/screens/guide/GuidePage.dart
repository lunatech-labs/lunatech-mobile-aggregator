import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/model/guide/Guide.dart';
import 'package:flutter_apps/model/guide/GuideItem.dart';
import 'package:flutter_apps/widgets/LunatechDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuidePage extends StatefulWidget{
  const GuidePage({super.key, required this.guideId});

  final String guideId;

  @override
  State<StatefulWidget> createState() => GuidePageState();
}

class GuidePageState extends State<GuidePage> {
  
  late Guide guide;
  int selected = 0;
  int total = 1;
  double progress = 0.0;
  bool isLoading = true;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/data/${widget.guideId}.json');
    final data = await json.decode(response);
    Guide tmp = Guide.fromJson(data);

    final prefs = await SharedPreferences.getInstance();
    List<String> selectedIds = prefs.getStringList(widget.guideId) ?? [];
    for (String id in selectedIds) {
      tmp.items[int.parse(id)]?.done = true;
    }
    setState(() {
      guide = tmp;
      selected = selectedIds.length;
      total = tmp.items.length;
      progress = selected / total;
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
    return _container();
  }

  Scaffold _loading() {
    return const Scaffold(
        drawer: LunatechDrawer(),
    );
  }

  Scaffold _container() {

    return Scaffold(
      appBar: AppBar(title: Text(guide.name)),
      drawer: const LunatechDrawer(),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(children: [_progressIndicator(), _guideList()],);
  }

  Widget _progressIndicator() {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return LinearProgressIndicator(value: (progress), semanticsLabel: 'Progress Indicator',color: secondaryColor,);
  }

  Widget _guideList() {
    List<Widget> list = [];
    guide.items.forEach((key, value) {list.add(_guideListBuilder(value));});
    return Expanded(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => list[index]),
    );
  }

  Widget _guideListBuilder(GuideItem guideItem) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
              checkColor: secondaryColor,
              fillColor: MaterialStateColor.resolveWith((states) => backgroundColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: secondaryColor, width: 1)),
              value: guideItem.done , onChanged: (bool? value) => _handleOnclick(value, guideItem)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12.0),
              child:
                Text(guideItem.detail)
            ))
        ],
      ),
    );
  }

  _handleOnclick(bool? value, GuideItem item) {
    setState(() {
      item.done = value!;
    });
    saveGuideItem(item);
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
    setState(() {
      selected = ids.length;
      progress = selected/total;
    });
  }

}

