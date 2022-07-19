
import 'dart:async';

import 'package:demo_cubit/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post.dart';

class PostView extends StatelessWidget {
  final scrollController = ScrollController();

   PostView({Key? key}) : super(key: key);

  void setupScollController (context){
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
        if(scrollController.position.pixels !=0){
              BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }
  // const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupScollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Cubit"),
      ),
      body: _postList(),
    );
  }

  Widget _postList(){
    return BlocBuilder<PostsCubit,PostsState>(
        builder: (context,state){
          if(state is PostLoading && state.isFirstfetch){
                return _loadingIndicator();
          }
          List<Post> posts = [];
          bool isLoading = false;

          if(state is PostLoading){
              posts = state.oldPosts;
              isLoading = true;
          }else if(state is PostLoaded){
                posts = state.posts;
          }
          return ListView.separated(
            controller: scrollController,
              itemBuilder: (context,index){

                if(index<posts.length){
                  return _post(posts[index],context);
                }else{
                  Timer(const Duration(milliseconds: 30),(){
                    scrollController.jumpTo(
                        scrollController.position.maxScrollExtent
                    );
                  });

                  return _loadingIndicator();
                }

              },
              separatorBuilder: (context,index){
            return Divider(
              color: Colors.grey[400],
            );
          },
              itemCount: posts.length + (isLoading ? 1 :0), );
        },
    );
  }
  Widget _loadingIndicator(){
    return const Padding(
        padding: EdgeInsets.all(8) ,
      child: Center(child: CircularProgressIndicator(),),
      
    );
     
  }

  Widget _post(Post post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("${post.id}.${post.title}",
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
        ),
        const SizedBox(height: 10,),
      Text(post.body)
      ],),
    );
  }
}
