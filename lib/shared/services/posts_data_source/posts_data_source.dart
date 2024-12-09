import '../../../models/post.dart';
import '../../../models/post_DTO.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();

  Future<void> addPost(PostDTO postDTO);

  Future <void> updatePost(post);

  Future<void> deletePost(postId);
}