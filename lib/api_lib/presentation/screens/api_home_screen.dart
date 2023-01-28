import 'package:blocapp/api_lib/data/models/post_model.dart';
import 'package:blocapp/api_lib/logic/cubits/post_cubit/post_cubit.dart';
import 'package:blocapp/api_lib/logic/cubits/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiHomeScreen extends StatelessWidget {
  const ApiHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Handling'),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostLoadedState) {
            return buildPostListView(state.postsList);
          } else if (state is PostErrorState) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }

  Widget buildPostListView(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
      itemBuilder: (context, index) {
        PostModel postModel = posts[index];

        return Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              title: Text(postModel.title),
              subtitle: Text(postModel.body),
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}
