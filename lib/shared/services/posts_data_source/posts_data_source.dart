import '../../../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();

  Future<void> addPost(Post post);
}