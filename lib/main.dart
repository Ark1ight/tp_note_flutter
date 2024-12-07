import 'package:crown/shared/services/local_posts_data_source/fake_local_posts_data_source.dart';
import 'package:crown/shared/services/posts_data_source/posts_fake_data_source.dart';
import 'package:crown/shared/services/posts_repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
        remoteDataSource: PostsFakeDataSource(),
        localPostsDataSource: FakeLocalPostsDataSource(),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          '/second': (context) => const HomePage(),
        },
      ),
    );
  }
}

