import 'package:flutter/cupertino.dart';

import '../../models/post.dart';

class ModifyPostScreen extends StatelessWidget {

  static Future<void> navigateTo(BuildContext context, Post post)  {
    return Navigator.pushNamed(context, '/modify_post', arguments: post);
  }

  final Post post;

  ModifyPostScreen({required this.post});

  @override
  _ModifyPostScreenState createState() => _ModifyPostScreenState();

  @override
  Widget build(BuildContext context) {
    return const Text('Modify Posteee');
  }
}

class _ModifyPostScreenState {
}

