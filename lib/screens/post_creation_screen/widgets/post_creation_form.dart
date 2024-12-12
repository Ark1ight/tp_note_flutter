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
    return Scaffold(
      backgroundColor: const Color(0xFF12131C),
      body: BlocListener<PostDetailBloc, PostDetailState>(
        listener: (context, state) async {
          if (state.status == PostDetailStatus.success) {
            await Future.delayed(const Duration(seconds: 1));
            HomePageScreen.navigateTo(context);
          }
        },
        child: BlocBuilder<PostDetailBloc, PostDetailState>(
          builder: (context, state) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF31304D),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(color: Color(0xFFB6BBC4)),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Color(0xFFB6BBC4),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the title of your thought';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description of your thought';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        if (!_buttonPressed)
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Submit'),
                            ),
                          ),
                        if (_buttonPressed)
                          switch (state.status) {
                            PostDetailStatus.loading => const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            PostDetailStatus.success => const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(child: Icon(Icons.check, color: Colors.green)),
                            ),PostDetailStatus.error => const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Error while creating data, try again"),
                                  Icon(Icons.error, color: Colors.red),
                                ],
                              ),
                            ),
                          ),
                            _ => const SizedBox.shrink(),
                          },
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}