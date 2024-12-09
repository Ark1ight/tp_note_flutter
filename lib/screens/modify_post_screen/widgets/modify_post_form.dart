import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milky_way/screens/home_page_screen/home_page_screen.dart';
import '../../../models/post.dart';
import '../../../shared/blocs/post_detail_bloc/post_detail_bloc.dart';

class ModifyPostForm extends StatefulWidget {
  final Post post;

  const ModifyPostForm({required this.post});

  @override
  _ModifyPostFormState createState() => _ModifyPostFormState();
}

class _ModifyPostFormState extends State<ModifyPostForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _buttonPressed = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
    _buttonPressed = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updatePost(BuildContext context) async {
    setState(() {
      _buttonPressed = true;
    });
    final postDetailBloc = context.read<PostDetailBloc>();
    final post = Post(
      id: widget.post.id,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    postDetailBloc.add(UpdatePost(post));
  }

  Future<void> _deletePost(BuildContext context) async {
    setState(() {
      _buttonPressed = true;
    });
    final postDetailBloc = context.read<PostDetailBloc>();
    postDetailBloc.add(DeletePost(widget.post.id));
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
                if (!_buttonPressed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _updatePost(context),
                        child: const Icon(Icons.save, color: Colors.black),
                      ),
                      ElevatedButton(
                        onPressed: state.status == PostDetailStatus.loading ? null : () => _deletePost(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Icon(Icons.delete, color: Colors.black),
                      ),
                    ],
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
          );
        },
      ),
    );
  }
}