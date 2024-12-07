import 'package:crown/app_exception.dart';
import 'package:crown/shared/services/posts_repository/posts_repository.dart';
import 'package:flutter/cupertino.dart';
import '../../../models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_state.dart';
part 'posts_event.dart';

class PostsBloc extends Bloc<PostsEvent,PostsState>{
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()){
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try{
        final posts = await postsRepository.getAllPosts();
        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (error){
        final appException = AppException.from(error);
        emit(state.copyWith(status: PostsStatus.error, exception: appException));
      }
    });
  }


}