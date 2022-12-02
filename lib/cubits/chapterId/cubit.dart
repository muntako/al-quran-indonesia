import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_quran/models/chapterId/chapterId.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class ChapterIdCubit extends Cubit<ChapterIdState> {
  static ChapterIdCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ChapterIdCubit>(context, listen: listen);

  ChapterIdCubit() : super(ChapterIdDefault());

  final repo = ChapterIdRepository();

  Future<void> fetch({bool? api = false}) async {
    emit(const ChapterIdFetchLoading());
    try {
      List<ChapterId?>? cached;

      if (api!) {
        cached = await repo.chapterIdApi();
      } else {
        cached = await repo.chapterIdHive();
      }

      if (cached == null) {
        List<ChapterId?>? data = await repo.chapterIdApi();
        emit(ChapterIdFetchSuccess(data: data));
      } else {
        emit(ChapterIdFetchSuccess(data: cached));
      }
    } catch (e) {
      emit(ChapterIdFetchFailed(message: e.toString()));
    }
  }
}
