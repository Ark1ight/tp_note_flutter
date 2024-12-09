import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milky_way/screens/modify_post_screen/modify_post_screen.dart';

import '../../../models/post.dart';

class ModifyPostItem extends StatelessWidget {

  const ModifyPostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context){
    return IconButton(onPressed: () {ModifyPostScreen.navigateTo(context,post);}, icon: const Icon(Icons.edit));
  }
}