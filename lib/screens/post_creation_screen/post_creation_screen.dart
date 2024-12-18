import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milky_way/screens/post_creation_screen/widgets/post_creation_form.dart';

class PostCreationScreen extends StatelessWidget {
  const PostCreationScreen({super.key});


  static Future<void> navigateTo(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const PostCreationScreen()),
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12131C),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Thoughts creation page', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF31304D),
      ),
      body: const PostCreationForm(),
    );
  }


}