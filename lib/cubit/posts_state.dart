part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {

}

// ignore: empty_constructor_bodies
class PostLoaded extends PostsState{
  final List<Post> posts;
  PostLoaded(this.posts);
 }

class PostLoading extends PostsState{
  final List<Post> oldPosts;
  final bool isFirstfetch;

  PostLoading(this.oldPosts,{this.isFirstfetch=false});
}
