import '../../util/UtilMethods.dart';

class BlogPostOverview {
  String? publicationDate;
  String? title;
  String? slug;
  String? lang;
  String? imageUrl;
  String? author;
  String? authorName;
  String? authorImg;
  String? excerpt;
  List<String>? tags;

  String? get reducedExcerpt =>
    excerpt == null ? null : keepOrShortenString(excerpt!, 100);

  String? get joinedTags => tags?.reduce((value, element) => "$value, $element");
  String? get reducedJoinedTags =>
      joinedTags == null ? null : keepOrShortenString(joinedTags!, 100);

  BlogPostOverview({
    this.publicationDate,
    this.title,
    this.slug,
    this.lang,
    this.imageUrl,
    this.author,
    this.authorName,
    this.authorImg,
    this.excerpt,
    this.tags,
  });

  BlogPostOverview.fromJson(dynamic json) {
    publicationDate = json['publication_date'];
    title = json['title'];
    slug = json['slug'];
    lang = json['lang'];
    imageUrl = json['image_url'];
    author = json['author'];
    authorName = json['author_name'];
    authorImg = json['author_img'];
    excerpt = json['excerpt'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publication_date'] = publicationDate;
    map['title'] = title;
    map['slug'] = slug;
    map['lang'] = lang;
    map['image_url'] = imageUrl;
    map['author'] = author;
    map['author_name'] = authorName;
    map['author_img'] = authorImg;
    map['tags'] = tags;
    return map;
  }
}
