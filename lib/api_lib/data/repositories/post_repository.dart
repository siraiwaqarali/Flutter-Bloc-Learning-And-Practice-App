import 'package:blocapp/api_lib/data/models/post_model.dart';
import 'package:blocapp/api_lib/data/repositories/api/api.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final API api = API();

  Future<List<PostModel>> fetchPosts() async {
    Response response = await api.sendRequest.get('/posts');
    List<Map<String, dynamic>> postsMapList =
        List<Map<String, dynamic>>.from(response.data);
    return postsMapList.map((e) => PostModel.fromMap(e)).toList();
  }
}
