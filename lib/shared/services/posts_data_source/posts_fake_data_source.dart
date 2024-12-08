import 'package:milky_way/shared/services/posts_data_source/posts_data_source.dart';

import '../../../models/post.dart';

class PostsFakeDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const Post(id: 1, title: 'Thought 1', description: 'The only limit to our realization of tomorrow is our doubts of today.'),
      const Post(id: 2, title: 'Thought 2', description: 'The future belongs to those who believe in the beauty of their dreams.'),
      const Post(id: 3, title: 'Thought 3', description: 'Do not watch the clock. Do what it does. Keep going.'),
      const Post(id: 4, title: 'Thought 4', description: 'Keep your face always toward the sunshine—and shadows will fall behind you.'),
      const Post(id: 5, title: 'Thought 5', description: 'The best way to predict the future is to create it.'),
      const Post(id: 6, title: 'Thought 6', description: 'You are never too old to set another goal or to dream a new dream.'),
      const Post(id: 7, title: 'Thought 7', description: 'What lies behind us and what lies before us are tiny matters compared to what lies within us.'),
      const Post(id: 8, title: 'Thought 8', description: 'The only way to do great work is to love what you do.'),
      const Post(id: 9, title: 'Thought 9', description: 'Success is not the key to happiness. Happiness is the key to success.'),
      const Post(id: 10, title: 'Thought 10', description: 'Believe you can and you’re halfway there.')
    ];
  }
}