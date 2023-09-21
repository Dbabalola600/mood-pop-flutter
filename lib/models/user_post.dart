import 'dart:convert';

class Post {
  final dynamic post;
  final dynamic category;
  final dynamic date;

  const Post({this.category, this.date, this.post});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        post: json["post"], date: json["date"], category: json["category"]);
  }
}
