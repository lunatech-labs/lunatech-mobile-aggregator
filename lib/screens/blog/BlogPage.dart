import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/model/blog/BlogPostOverview.dart';
import 'package:flutter_apps/services/BlogAppService.dart';
import 'package:flutter_apps/services/GoogleService.dart';
import 'package:flutter_apps/util/UtilMethods.dart';
import 'package:flutter_apps/widgets/LunatechLoading.dart';
import 'package:flutter_apps/widgets/LunatechScaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key, this.authorNickname, this.authorName});

  static const String title = "LunaBlog";

  final String? authorNickname;
  final String? authorName;

  @override
  State<BlogPage> createState() => BlogPageState();
}

class BlogPageState extends State<BlogPage> {
  final Image placeholder = Image.asset("lib/static/logo-lunatech.png");
  final ScrollController _controller = ScrollController();

  int _page = 1;
  bool _loading = true;
  List<BlogPostOverview> posts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadData());
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return LunatechScaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
                widget.authorName ?? widget.authorNickname ?? BlogPage.title)),
        body: ListView.builder(
            controller: _controller,
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
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: post.imageUrl != null
            ? CachedNetworkImage(
                imageUrl: post.imageUrl!,
                placeholder: (_, __) => placeholder,
                errorWidget: (_, __, ___) => placeholder,
                fit: BoxFit.fill)
            : placeholder);
  }

  Widget _postContent(BlogPostOverview post) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(minHeight: 190),
      color: Theme.of(context).colorScheme.background,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => navigateToPage(
                          context,
                          BlogPage(
                              authorNickname: post.authorName,
                              authorName: post.author)),
                      child: Text(post.author ?? "Unknown")),
                  Text(post.publicationDate ?? "")
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(post.title ?? "No Title",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                  height: 90,
                  child: Text(post.excerpt ?? "", overflow: TextOverflow.ellipsis, maxLines: 4)),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    post.reducedJoinedTags ?? "",
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
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
                ),
              ],
            )
          ]),
    );
  }

  void _loadData() async {
    _loading = true;
    LunatechLoading loadingScreen = showLoadingScreen(context);
    posts.addAll(await BlogAppService()
        .getPosts(lang: "en", author: widget.authorNickname, page: _page)
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't connect to Blog App")));
      return List.empty();
    }));

    if (!mounted) return;
    loadingScreen.stopLoading(context);
    setState(() {});
    _loading = false;
  }

  void _scrollListener() {
    if(!_loading && _controller.position.extentAfter < 300) {
      _page++;
      _loadData();
    }
  }
}
