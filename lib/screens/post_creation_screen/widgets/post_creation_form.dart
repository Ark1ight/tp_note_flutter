import 'package:flutter/material.dart';

class PostCreationForm extends StatelessWidget {
  const PostCreationForm({super.key, required BuildContext context});

  @override
  Widget build( BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text('Post Creation Form'),
      ),
    );
  }
}