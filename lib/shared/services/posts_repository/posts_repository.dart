import '../../../models/post.dart';
import '../local_posts_data_source/local_posts_data_source.dart';
import '../posts_data_source/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource remoteDataSource;
  final LocalPostsDataSource localPostsDataSource;

  PostsRepository({
    required this.remoteDataSource,
    required this.localPostsDataSource,
  });

  Future<List<Post>> getAllPosts() async {
    try {
      final posts = await remoteDataSource.getAllPosts();
      localPostsDataSource.savePosts(posts);
      return posts;
    } catch (error){
      return localPostsDataSource.getAllPosts();
    }
  }

  addPost(post) async {
    try{
      await remoteDataSource.addPost(post);
    } catch (error){
      rethrow;
    }
  }
}