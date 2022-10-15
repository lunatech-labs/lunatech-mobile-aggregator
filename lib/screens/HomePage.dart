import 'package:flutter/material.dart';
import 'package:flutter_apps/model/blog/BlogPostOverview.dart';
import 'package:flutter_apps/services/BlogAppService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String title = "LunatechApp";

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<BlogPostOverview> posts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadData());
  }

  @override
  Widget build(BuildContext context) {

    return LunatechScaffold(
        appBar: AppBar(title: const Text(HomePage.title)),
        body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) =>
                _postOverviewBuilder(posts[index])));
  }

  Widget _postOverviewBuilder(BlogPostOverview post) {
    return FractionallySizedBox(
      widthFactor: 0.92,
      child: Material(
        child: InkWell(
          onTap: () => launchUrl(BlogAppService().getPostUrl(post)),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
            child: Column(
              children: [_postImage(post), _postContent(post)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _postImage(BlogPostOverview post) {
    return Container(
      height: 180,
      decoration: BoxDecoration(image: getItemBackgroundImage(post)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    );
  }

  Widget _postContent(BlogPostOverview post) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 160,
      color: Theme.of(context).colorScheme.background,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(post.author ?? "Unknown"),
                  Text(post.publicationDate ?? "")
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(post.title ?? "No Title",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(
                post.tags?.reduce((value, element) => "$value, $element") ?? "",
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Read the Post",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 12,
                )
              ],
            )
          ]),
    );
  }

  // Find a way to cache images, currently it's calling every time you scroll on a tile
  DecorationImage? getItemBackgroundImage(BlogPostOverview post) {
    return post.imageUrl != null
        ? DecorationImage(image: NetworkImage(post.imageUrl!), fit: BoxFit.fill)
        : null;
  }

  void _loadData() async {
    LunatechLoading loadingScreen = showLoadingScreen(context);
    posts = await BlogAppService()
        .getPosts(lang: "en")
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't connect to Blog App")));
      return List.empty();
    });

    if(!mounted) return;
    loadingScreen.stopLoading(context);
    setState(() {});
  }
}
