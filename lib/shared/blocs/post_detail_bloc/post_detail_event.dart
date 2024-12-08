part of 'post_detail_bloc.dart';

@immutable
sealed class PostDetailEvent{
  const PostDetailEvent();
}

class AddPost extends PostDetailEvent{
  final Post post;

  const AddPost(this.post);
}