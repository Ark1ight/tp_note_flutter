import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milky_way/screens/post_creation_screen/widgets/post_creation_form.dart';

class PostCreationScreen extends StatelessWidget {
  const PostCreationScreen({super.key});


  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/postCreation');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post '),
      ),
      body: PostCreationForm(),
    );
  }


}