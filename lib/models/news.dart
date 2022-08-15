import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String? title;
  final String? description;
  final DateTime? publishedDate;
  final String? link;
  final String? image;
  final List<Comment>? comment;
  final String? id;
  final List<String>? like;
  final List<String>? share;

  News({
    this.title = '',
    this.like = const [],
    this.description = '',
    this.publishedDate,
    this.link = '',
    this.id = '',
    this.share = const [],
    this.image = '',
    this.comment = const [],
  });
  Map<String, dynamic> toJson() => {
        'comment': List<Comment>.from(comment!.map((e) => e.toJson())),
        'description': description,
        'id': id,
        'image': image,
        'like': List<String>.from(like!.map((e) => e)),
        'share': List<String>.from(share!.map((e) => e)),
        'title': title,
        'link': link,
        'publishedDate': publishedDate ?? DateTime.now()
      };

  static News fromJson(Map<String, dynamic> json) => News(
      id: json['id'],
      title: json['title'],
      comment:
          List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
      description: json['description'],
      image: json['image'],
      like: List<String>.from(json['like'].map((x) => x)),
      link: json['link'],
      publishedDate: (json['publishedDate'] as Timestamp).toDate(),
      share: List<String>.from(json["share"].map((x) => x)));
}

class Comment {
  final DateTime? date;
  final String? email;
  final String? text;
  final String? username;

  Comment({this.date, this.email, this.text, this.username});
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        email: json["email"],
        text: json["text"],
        username: json["username"],
        date: (json['date'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "text": text,
        "username": username,
        "date": date,
      };
}
