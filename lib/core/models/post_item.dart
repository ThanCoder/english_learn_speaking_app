import 'package:t_db/t_db.dart';

class PostItemAdapter extends TDAdapter<PostItem> {
  @override
  PostItem fromMap(Map<String, dynamic> map) {
    return PostItem.fromJson(map);
  }

  @override
  int getId(PostItem value) {
    return value.id;
  }

  @override
  int getUniqueFieldId() {
    return 2;
  }

  @override
  Map<String, dynamic> toMap(PostItem value) {
    return value.toJson();
  }
}

class PostItem {
  final int id;
  final int postId;
  final String title;
  final String desc;
  final DateTime date;

  const PostItem({
    required this.id,
    required this.postId,
    required this.title,
    required this.desc,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'title': title,
      'desc': desc,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      id: json['id'],
      postId: json['postId'],
      title: json['title'],
      desc: json['desc'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }
}
