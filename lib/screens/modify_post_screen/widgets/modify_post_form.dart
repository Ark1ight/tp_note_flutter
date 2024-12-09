import 'package:flutter/material.dart';
import '../../../models/post.dart';

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

  void _savePost(BuildContext context) {

  }

  void _deletePost() {
    Navigator.pop(context);
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
                onPressed: _savePost(context),
                child: const Text('Save', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: _deletePost,
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