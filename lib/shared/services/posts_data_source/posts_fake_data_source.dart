import 'package:crown/shared/services/posts_data_source/posts_data_source.dart';

import '../../../models/post.dart';

class PostsFakeDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) => Post(id: index, title: 'Post $index', description: 'Description $index'));
  }
}