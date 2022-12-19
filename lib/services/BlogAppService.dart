import 'dart:convert';

import 'package:flutter_apps/model/blog/BlogPostOverview.dart';

import 'package:http/http.dart' as http;

class BlogAppService {
  static const blogUrl = "blog.lunatech.com";

  static final BlogAppService _instance = BlogAppService._internal();

  BlogAppService._internal();

  factory BlogAppService() {
    return _instance;
  }

  Future<List<BlogPostOverview>> getPosts(
      {limit = 20, page = 1, String? tag, String? author, String? lang}) {
    final Map<String, dynamic> queryParams = {
      "limit": limit.toString(),
      "page": page.toString()
    };
    if (tag != null) {
      queryParams["tag"] = tag;
    }
    if (author != null) {
      queryParams["author"] = author;
    }
    if (lang != null) {
      queryParams["lang"] = lang;
    }

    return http.get(Uri.https(blogUrl, "/api/posts", queryParams))
        .then((response) => jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>)
        .then((json) => json.map((post) => BlogPostOverview.fromJson(post)).toList());
  }

  Uri getPostUrl(BlogPostOverview post) {
    return Uri.https(blogUrl, post.slug!);
  }
}
