part of 'post_detail_bloc.dart';

enum PostDetailStatus {
  initial,
  loading,
  success,
  error
}

class PostDetailState{
  final PostDetailStatus status;
  final Post? post;
  final AppException? exception;

  const PostDetailState({
    this.status = PostDetailStatus.initial,
    this.post,
    this.exception
  });

  PostDetailState copyWith({
    PostDetailStatus? status,
    Post? post,
    AppException? exception
  }){
    return PostDetailState(
      status: status ?? this.status,
      post: post ?? this.post,
      exception: exception ?? this.exception
    );
  }

}