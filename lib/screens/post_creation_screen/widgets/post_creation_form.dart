import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milky_way/screens/home_page_screen/home_page_screen.dart';
import 'package:milky_way/shared/blocs/post_detail_bloc/post_detail_bloc.dart';

import '../../../models/post.dart';
import '../../../models/post_DTO.dart';

class PostCreationForm extends StatefulWidget {
  const PostCreationForm({super.key});

  @override
  _PostCreationFormState createState() => _PostCreationFormState();
}

class _PostCreationFormState extends State<PostCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {

      final title = _titleController.text;
      final description = _descriptionController.text;
      _addPost(title, description);

      HomePageScreen.navigateTo(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the title of your thought';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description of your thought';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _addPost(String title, String description) {
    final postsBloc = BlocProvider.of<PostDetailBloc>(context);
    postsBloc.add(AddPost(PostDTO(title: title, description: description)));
  }
}