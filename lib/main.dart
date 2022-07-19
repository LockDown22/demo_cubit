import 'package:demo_cubit/cubit/posts_cubit.dart';
import 'package:demo_cubit/data/respositories/posts_respository.dart';
import 'package:demo_cubit/data/service/posts_service.dart';
import 'package:demo_cubit/presentation/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp( PaginationApp(repository: PostsRepository(PostsService()),));
}

class PaginationApp extends StatelessWidget {
  final PostsRepository repository;
  const PaginationApp({Key? key, required this.repository}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: PostView(),
      ),
    );
  }
}
