import 'package:flutter/material.dart';
import 'package:flutter_apps/model/blog/BlogPostOverview.dart';
import 'package:flutter_apps/services/BlogAppService.dart';
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
        body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) =>
                _postOverviewBuilder(posts[index])));
  }

  Widget _postOverviewBuilder(BlogPostOverview post) {
    return SizedBox(
      height: 50,
      child: Material(
        child: InkWell(
          child: Center(child: Text(post.title ?? "No Title")),
          onTap: () => launchUrl(BlogAppService().getPostUrl(post)),
        ),
      ),
    );
  }

  void _loadData() async {
    posts = await BlogAppService().getPosts().onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't connect to Blog App")));
      return List.empty();
    });
    setState(() => loading = false);
  }
}
