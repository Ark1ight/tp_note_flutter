part of 'post_detail_bloc.dart';

@immutable
sealed class PostDetailEvent{
  const PostDetailEvent();
}

class AddPost extends PostDetailEvent{
  final PostDTO postDTO;

  const AddPost(this.postDTO);
}

class UpdatePost extends PostDetailEvent{
  final Post post;

  const UpdatePost(this.post);
}

class DeletePost extends PostDetailEvent{
  final int postId;

  const DeletePost(this.postId);
}