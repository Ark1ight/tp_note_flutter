
import 'package:milky_way/shared/services/local_posts_data_source/local_posts_data_source.dart';

import '../../../models/post.dart';

class FakeLocalPostsDataSource extends LocalPostsDataSource {

  @override
  Future<List<Post>> getAllPosts() async {
    return [];
  }

  @override
  Future<void> savePosts(List<Post> posts) async {
    return;
  }





}