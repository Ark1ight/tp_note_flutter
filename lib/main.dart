import 'package:milky_way/shared/blocs/posts_bloc/posts_bloc.dart';
import 'package:milky_way/shared/services/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:milky_way/shared/services/posts_data_source/posts_fake_data_source.dart';
import 'package:milky_way/shared/services/posts_repository/posts_repository.dart';
import 'package:milky_way/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_screen/home_page.dart';

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
      child: BlocProvider(
        create: (context) => PostsBloc(
          postsRepository: RepositoryProvider.of<PostsRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const HomePageScreen(),
          },
          onGenerateRoute: (routeSettings) {
            Widget screen = Container(color: Colors.pink);
            final argument = routeSettings.arguments;
            switch (routeSettings.name) {
              case '/test':
                screen = Container(color: Colors.blue, child: const Center(child: Text('Test Page')));
                break;
              case '/postDetail':
              /*
                if (argument is Post) {
                  screen = PostDetailScreen(post: argument);
                }
                */
                screen = Container(color: Colors.red, child: const Center(child: Text('Post Detail Page')));
                break;
            }
            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}
