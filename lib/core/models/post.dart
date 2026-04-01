import 'package:t_db/t_db.dart';

class PostAdapter extends TDAdapter<Post> {
  @override
  Post fromMap(Map<String, dynamic> map) {
    return Post.fromJson(map);
  }

  @override
  int getId(Post value) {
    return value.id;
  }

  @override
  int getUniqueFieldId() {
    return 1;
  }

  @override
  Map<String, dynamic> toMap(Post value) {
    return value.toJson();
  }
}

class Post {
  final int id;
  final String title;
  final String url;
  final String desc;
  final DateTime date;

  const Post({
    this.id = 0,
    this.desc = '',
    this.url = '',
    required this.title,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'desc': desc,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      desc: json['desc'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }

  Post copyWith({
    int? id,
    String? title,
    String? url,
    String? desc,
    DateTime? date,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      desc: desc ?? this.desc,
      date: date ?? this.date,
    );
  }
}
