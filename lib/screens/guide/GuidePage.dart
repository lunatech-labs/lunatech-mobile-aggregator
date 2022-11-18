import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/model/guide/Guide.dart';
import 'package:flutter_apps/model/guide/GuideItem.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechDrawer.dart';
import 'package:flutter/material.dart';



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


    setState(() {
      guide = Guide.fromJson(data);
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
          itemBuilder: (context, index) => _guideListBuilder(guide.items[index]))
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

}

