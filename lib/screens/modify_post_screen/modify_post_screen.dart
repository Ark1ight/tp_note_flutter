import 'package:flutter/material.dart';
import '../../models/post.dart';
import 'widgets/modify_post_form.dart';

class ModifyPostScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, '/modify_post', arguments: post);
  }

  final Post post;

  ModifyPostScreen({required this.post});

  @override
  _ModifyPostScreenState createState() => _ModifyPostScreenState();
}

class _ModifyPostScreenState extends State<ModifyPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12131C),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Thought modifying page', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF31304D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ModifyPostForm(post: widget.post),
      ),
    );
  }
}