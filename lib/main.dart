import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_article_usecase.dart';
import 'package:news_app/features/news/presentation/bloc/articles/remote/remote_article_cubit.dart';
import 'package:news_app/injection_container.dart';
import 'package:news_app/features/news/presentation/screens/feed_activity.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleCubit>(
      // create: (context) => RemoteArticleCubit(sl<GetArticleUseCase>()),
      create: (BuildContext context) => sl<RemoteArticleCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: FeedActivity(),
      ),
    );
  }
}
