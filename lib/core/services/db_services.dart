import 'package:english_learn_speaking/core/models/post.dart';
import 'package:english_learn_speaking/core/models/post_item.dart';
import 'package:english_learn_speaking/more_libs/setting/core/path_util.dart';
import 'package:t_db/t_db.dart';

class DBServices {
  final db = TDB();
  final config = DBConfig.getDefault().copyWith(saveLocalDBLock: false);

  Future<void> init() async {
    await db.open(PathUtil.getDatabasePath(name: 'post.db'), config: config);
    db.setAdapterNotExists<Post>(PostAdapter());
    db.setAdapterNotExists<PostItem>(PostItemAdapter());
  }

  Future<List<Post>> getAllPost() async {
    return await db.getAll<Post>();
  }

  Future<int> addPost(Post post) async {
    return await db.add<Post>(post);
  }

  Future<bool> deletePostById(int id) async {
    return await db.deleteById(id);
  }

  Future<List<PostItem>> getAllPostItem() async {
    return await db.getAll<PostItem>();
  }

  Future<int> addPostItem(PostItem item) async {
    return await db.add<PostItem>(item);
  }

  Future<bool> deletePostItemById(int id) async {
    return await db.deleteById(id);
  }
}
