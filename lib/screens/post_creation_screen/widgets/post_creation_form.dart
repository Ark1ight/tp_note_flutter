import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milky_way/screens/home_page_screen/home_page_screen.dart';
import 'package:milky_way/shared/blocs/post_detail_bloc/post_detail_bloc.dart';

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
  bool _buttonPressed = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _buttonPressed = true;
      });

      final title = _titleController.text;
      final description = _descriptionController.text;
      _addPost(title, description);
    }
  }

  void _addPost(String title, String description) {
    final postDetailBloc = context.read<PostDetailBloc>();
    postDetailBloc.add(AddPost(PostDTO(title: title, description: description)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostDetailBloc, PostDetailState>(
      listener: (context, state) async {
        if (state.status == PostDetailStatus.success) {
          await Future.delayed(const Duration(seconds: 1));
          HomePageScreen.navigateTo(context);
        }
      },
      child: BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, state) {
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
                  if (!_buttonPressed)
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                  if (_buttonPressed)
                    switch (state.status) {
                      PostDetailStatus.loading => const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      ),
                      PostDetailStatus.success => const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(Icons.check, color: Colors.green),
                      ),
                      _ => const SizedBox.shrink(),
                    },
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}