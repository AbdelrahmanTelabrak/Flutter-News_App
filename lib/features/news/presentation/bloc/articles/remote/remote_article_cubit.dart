import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/entities/article_entity.dart';
import '../../../../domain/usecases/get_article_usecase.dart';

part 'remote_article_state.dart';

class RemoteArticleCubit extends Cubit<RemoteArticleState> {

  final GetArticleUseCase _usecase;
  RemoteArticleCubit(this._usecase) : super(const RemoteArticleInitial());

  Future<void> getNews({required String category}) async {
    emit(const RemoteArticleLoading());
    final dataState = await _usecase.call(params: category);
    if (dataState is DataSuccess) {
      print(dataState.data!.toString());
      emit(RemoteArticleDone(dataState.data!));
    } else if (dataState is DataFailed) {
      print(dataState.error.toString());
      emit(RemoteArticleError(dataState.error!));

    }
  }
}
