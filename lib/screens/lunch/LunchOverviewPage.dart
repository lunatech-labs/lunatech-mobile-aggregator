import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/model/lunch/dto/Dish.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/services/LunchAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';

import '../../model/lunch/dto/Event.dart';

class LunchOverviewPage extends StatefulWidget {
  const LunchOverviewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LunchOverviewPageState();
  }
}

class _LunchOverviewPageState extends State<LunchOverviewPage> {
  List<Event> events = [];
  List<Event> filteredEvents = [];

  late String userEmail;

  _LunchOverviewPageState() {
    userEmail = GoogleService().getAccount().email;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadData());
  }

  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: true,
            title: Text('Lunch App'),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (_, index) => eventToItem(events[index]),
            childCount: events.length,
          ))
        ],
      ),
    );
  }

  Widget eventToItem(Event event) {
    return FractionallySizedBox(
      widthFactor: 0.92,
      child: Material(
        child: InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
            child: Column(
              children: [content(event)],
            ),
          ),
        ),
      ),
    );
  }

  Widget content(Event event) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 190,
      color: Theme.of(context).colorScheme.background,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(event.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  if (event.attending)
                    const Text(
                      "✔️ Going ",
                      style: TextStyle(fontSize: 10),
                    ),
                ],
              ),
            ),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
              child: Text(
                _getEventDietaryOptions(event).dietaryEmojis(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ]),
        ]),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(event.location),
            Text(event.formattedDate),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
              child: Text(
                "👥 ${event.attendees}",
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ]),
        ]),
      ]),
    );
  }

  Dish _getEventDietaryOptions(Event event) {
    return event.dishes.reduce((value, element) => Dish(
          "",
          "",
          "",
          value.isVegetarian || element.isVegetarian,
          value.isHalal || element.isHalal,
          value.hasSeaFood || element.hasSeaFood,
          value.hasPork || element.hasPork,
          value.hasBeef || element.hasBeef,
          value.hasChicken || element.hasChicken,
          value.isGlutenFree || element.isGlutenFree,
          value.hasLactose || element.hasLactose,
        ));
  }

  void _loadData() async {
    final loadingScreen = showLoadingScreen(context);
    events = await LunchAppService().getEvents();
    if (!mounted) return;
    loadingScreen.stopLoading(context);
    setState(() => filteredEvents = events);
  }
}
