import 'package:blocapp/api_lib/data/models/post_model.dart';
import 'package:blocapp/api_lib/data/repositories/post_repository.dart';
import 'package:blocapp/api_lib/logic/cubits/post_cubit/post_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository = PostRepository();

  PostCubit() : super(PostLoadingState()) {
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      List<PostModel> postsList = await _postRepository.fetchPosts();
      emit(PostLoadedState(postsList));
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        emit(
          PostErrorState(
              'Can\'t fetch posts, please check your internet connection!'),
        );
      } else {
        emit(PostErrorState(e.type.toString()));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }
}
