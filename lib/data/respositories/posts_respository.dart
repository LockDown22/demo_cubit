import 'package:demo_cubit/data/service/posts_service.dart';

import '../models/post.dart';

class PostsRepository{
  final PostsService service;

  PostsRepository(this.service);

  Future<List<Post>> fetchPosts(int page) async {
   final posts = await service.fetchPosts(page);

  return posts.map((e) =>  Post.fromJson(e)).toList();

  }



}