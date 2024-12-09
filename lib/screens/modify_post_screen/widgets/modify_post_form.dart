import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milky_way/screens/home_page_screen/home_page_screen.dart';
import '../../../models/post.dart';
import '../../../shared/blocs/post_detail_bloc/post_detail_bloc.dart';

class ModifyPostForm extends StatefulWidget {
  final Post post;

  ModifyPostForm({required this.post});

  @override
  _ModifyPostFormState createState() => _ModifyPostFormState();
}

class _ModifyPostFormState extends State<ModifyPostForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updatePost(BuildContext context) {
    final postDetailBloc = context.read<PostDetailBloc>();
    final post = Post(
      id: widget.post.id,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    postDetailBloc.add(UpdatePost(post));

    HomePageScreen.navigateTo(context);

  }

  void _deletePost(BuildContext context) {
    final postDetailBloc = context.read<PostDetailBloc>();
    postDetailBloc.add(DeletePost(widget.post.id));

    HomePageScreen.navigateTo(context);


  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _updatePost(context),
                child: const Text('Save', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () => _deletePost(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}