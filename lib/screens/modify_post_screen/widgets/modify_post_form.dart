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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_buttonPressed)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                                onPressed: () {
                                  HomePageScreen.navigateTo(context);
                                },
                              ),
                              const Text("Go back", style: TextStyle(color: Colors.white, fontSize: 20),),
                            ],
                          ),
                        ),
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
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          PostDetailStatus.success => const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(child: Icon(Icons.check, color: Colors.green),),
                          ),
                          PostDetailStatus.error => const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Error while handling data, try again"),
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
            );
          },
        ),
      ),
    );
  }
}