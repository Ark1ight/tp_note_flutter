import 'package:milky_way/screens/modify_post_screen/modify_post_screen.dart';
import 'package:milky_way/screens/post_creation_screen/post_creation_screen.dart';
import 'package:milky_way/shared/blocs/posts_bloc/posts_bloc.dart';
import 'package:milky_way/shared/blocs/post_detail_bloc/post_detail_bloc.dart';
import 'package:milky_way/shared/services/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:milky_way/shared/services/posts_data_source/posts_fake_data_source.dart';
import 'package:milky_way/shared/services/posts_repository/posts_repository.dart';
import 'package:milky_way/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/post.dart';
import 'screens/home_page_screen/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        remoteDataSource: PostsFakeDataSource(),
        localPostsDataSource: FakeLocalPostsDataSource(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsBloc(
              postsRepository: RepositoryProvider.of<PostsRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => PostDetailBloc(
              postsRepository: RepositoryProvider.of<PostsRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const HomePageScreen(),
            '/postCreation': (context) => const PostCreationScreen(),

          },
          onGenerateRoute: (routeSettings) {
            Widget screen = Container(color: Colors.pink);
            final argument = routeSettings.arguments;
            switch (routeSettings.name) {
              case '/modify_post':
                if (argument is Post) {
                  screen = ModifyPostScreen(post: argument);
                }
                break;
            }
            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}