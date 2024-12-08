part of 'post_detail_bloc.dart';

@immutable
sealed class PostDetailEvent{
  const PostDetailEvent();
}

class AddPost extends PostDetailEvent{
  final PostDTO postDTO;

  const AddPost(this.postDTO);
}