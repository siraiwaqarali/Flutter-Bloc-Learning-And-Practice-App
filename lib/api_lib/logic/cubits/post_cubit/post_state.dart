import 'package:blocapp/api_lib/data/models/post_model.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> postsList;
  PostLoadedState(this.postsList);
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState(this.error);
}
