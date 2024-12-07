import 'package:crown/models/post.dart';
import 'package:crown/shared/services/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:crown/shared/services/posts_data_source/posts_fake_data_source.dart';
import 'package:crown/shared/services/posts_repository/posts_repository.dart';
import 'package:crown/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
        },
        onGenerateRoute: (routeSettings){
          Widget screen = Container(color: Colors.pink);
          final argument = routeSettings.arguments;
          switch(routeSettings.name){
            case '/test':
              screen = Container(color: Colors.blue, child: const Center(child: Text('Test Page')));
            case 'postDetail':
              /*
              if(argument is Post){
                screen = PostDetailScreen(post: argument);
              }
              */
              screen = Container(color: Colors.green, child: const Center(child: Text('Post Detail Page')));
              break;
          }
          return MaterialPageRoute(builder: (context) => screen);
        },
      ),
    );
  }
}


