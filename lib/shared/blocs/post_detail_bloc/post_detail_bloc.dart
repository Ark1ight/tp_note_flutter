import 'package:flutter/cupertino.dart';
import '../../../app_exception.dart';
import '../../../models/post.dart';
import '../../../models/post_DTO.dart';
import '../../services/posts_repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_detail_state.dart';
part 'post_detail_event.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostsRepository postsRepository;

  PostDetailBloc({required this.postsRepository}) : super(const PostDetailState()) {
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  void _onAddPost(AddPost event, Emitter<PostDetailState> emit) async {
    emit(state.copyWith(status: PostDetailStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    try {
      await postsRepository.addPost(event.postDTO);
      emit(state.copyWith(status: PostDetailStatus.success));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: PostDetailStatus.initial));
    } catch (error) {
      final appException = AppException.from(error);
      emit(state.copyWith(status: PostDetailStatus.error, exception: appException));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostDetailState> emit) async {
    emit(state.copyWith(status: PostDetailStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    try {
      await postsRepository.updatePost(event.post);
      emit(state.copyWith(status: PostDetailStatus.success));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: PostDetailStatus.initial));
    } catch (error) {
      final appException = AppException.from(error);
      emit(state.copyWith(status: PostDetailStatus.error, exception: appException));
    }
  }

  void _onDeletePost(DeletePost event, Emitter<PostDetailState> emit) async {
    emit(state.copyWith(status: PostDetailStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    try {
      await postsRepository.deletePost(event.postId);
      emit(state.copyWith(status: PostDetailStatus.success));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: PostDetailStatus.initial));
    } catch (error) {
      final appException = AppException.from(error);
      emit(state.copyWith(status: PostDetailStatus.error, exception: appException));
    }
  }
}