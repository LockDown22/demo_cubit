import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/post.dart';
import '../data/respositories/posts_respository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.repository) : super(PostsInitial());

  int page = 1;
  final PostsRepository repository;

  void loadPosts(){
    if(state is PostLoading)return;

      final currentState = state;
      var oldpPosts = <Post>[];

    if(currentState is PostLoaded){
      oldpPosts = currentState.posts;
    }


    emit(PostLoading(oldpPosts,isFirstfetch: page==1));

    repository.fetchPosts(page).then((newPosts) {
      page++;
      final posts = (state as PostLoading).oldPosts;
        posts.addAll(newPosts);
      emit(PostLoaded(posts));
    });
  }
}
