
import 'package:milky_way/shared/services/local_posts_data_source/local_posts_data_source.dart';

import '../../../models/post.dart';
import '../../../models/post_DTO.dart';

class FakeLocalPostsDataSource extends LocalPostsDataSource {

  @override
  Future<List<Post>> getAllPosts() async {
    return [];
  }

  @override
  Future<void> savePosts(List<Post> posts) async {
    return;
  }

  @override
  Future<void> addPost(PostDTO postDTO) async{
    return;
  }

  @override
  Future<void> updatePost(post) async{
    return;
  }

  @override
  Future<void> deletePost(postId) async{
    return;
  }





}