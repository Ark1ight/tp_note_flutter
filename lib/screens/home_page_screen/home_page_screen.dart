import 'package:milky_way/screens/home_page_screen/widgets/post_list_item.dart';
import 'package:milky_way/screens/post_creation_screen/post_creation_screen.dart';
import 'package:milky_way/shared/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_exception.dart';
import '../../models/post.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  static Future<void> navigateTo(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePageScreen()),
          (route) => false,
    );
  }

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsState>(
      listener: (context, state) {
        if (state.status == PostsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("error"),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF12131C),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Milky Way',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF31304D),
        ),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            return switch (state.status) {
              PostsStatus.initial || PostsStatus.loading => _buildLoading(context),
              PostsStatus.success => _buildPosts(context, state.posts),
              PostsStatus.error => _buildError(context, state.exception),
            };
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onCreatePostPressed,
          backgroundColor: const Color(0xFF31304D),
          child: const Icon(Icons.add_card, color: Colors.white),
        ),
      ),
    );
  }

  void _getAllPosts() {
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(const GetAllPosts(''));
  }

  void _onCreatePostPressed() {
    PostCreationScreen.navigateTo(context);
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildPosts(BuildContext context, List<Post> posts) {
    return RefreshIndicator(
      onRefresh: () async => _getAllPosts(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostListItem(post: post);
        },
      ),
    );
  }

  Widget _buildError(BuildContext context, AppException? exception) {
    if (exception == null) {
      return const Center(
        child: Text('An unknown error occurred.'),
      );
    }
    return Center(
      child: Text(exception.toString()),
    );
  }
}
