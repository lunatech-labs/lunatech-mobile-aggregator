import 'package:flutter/material.dart';
import 'package:flutter_apps/model/blog/BlogPostOverview.dart';
import 'package:flutter_apps/services/BlogAppService.dart';
import 'package:flutter_apps/widgets/LunatechBackground.dart';
import 'package:flutter_apps/widgets/LunatechListItem.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/LunatechDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String title = "LunatechApp";

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<BlogPostOverview> posts;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    if (loading) _loadData();

    return loading ? const LunatechLoading() : _body();
  }

  Scaffold _body() {
    return Scaffold(
        appBar: AppBar(title: const Text(HomePage.title)),
        drawer: const LunatechDrawer(),
        body: LunatechBackground(
          child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) =>
                  _postOverviewBuilder(posts[index])),
        ));
  }

  Widget _postOverviewBuilder(BlogPostOverview post) {
    return LunatechListItem(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(image: getItemBackgroundImage(post)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Align(
              alignment: Alignment.bottomCenter, child: getItemTextBox(post)),
        ),
        onTap: () => launchUrl(BlogAppService().getPostUrl(post)),
      ),
    );
  }

  Container getItemTextBox(BlogPostOverview post) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.black38.withOpacity(0.6),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text(post.title ?? "No Title",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  // Find a way to cache images, currently it's calling every time you scroll on a tile
  DecorationImage? getItemBackgroundImage(BlogPostOverview post) {
    return post.imageUrl != null
        ? DecorationImage(image: NetworkImage(post.imageUrl!), fit: BoxFit.fill)
        : null;
  }

  void _loadData() async {
    posts = await BlogAppService()
        .getPosts(lang: "en")
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't connect to Blog App")));
      return List.empty();
    });
    setState(() => loading = false);
  }
}
