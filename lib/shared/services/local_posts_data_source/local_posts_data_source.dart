import '../../../models/post.dart';
import '../posts_data_source/posts_data_source.dart';

abstract class LocalPostsDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getAllPosts();

  Future<void> savePosts(List<Post> posts);

}