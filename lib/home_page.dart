import 'package:crown/shared/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

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
    return BlocListener<PostsBloc,PostsState>(
      listener: (context,state){
        if(state.status == PostsStatus.error){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("error"),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: BlocBuilder<PostsBloc,PostsState>(
          builder: (context,state){
            if(state.status == PostsStatus.loading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state.status == PostsStatus.success){
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context,index){
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          },
        ),
      ),
    );
  }

  void _getAllPosts() {
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(const GetAllPosts(''));

  }


}
