import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_quran/models/surah/surah.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class SurahCubit extends Cubit<SurahState> {
  static SurahCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<SurahCubit>(context, listen: listen);

  SurahCubit() : super(SurahDefault());

  final repo = SurahRepository();

  Future<void> fetch({bool? api = false}) async {
    emit(const SurahFetchLoading());
    try {
      List<Surah?>? cached;

      if (api!) {
        cached = await repo.surahApi();
      } else {
        cached = await repo.surahHive();
      }

      if (cached == null) {
        List<Surah?>? data = await repo.surahApi();
        emit(SurahFetchSuccess(data: data));
      } else {
        emit(SurahFetchSuccess(data: cached));
      }
    } catch (e) {
      emit(SurahFetchFailed(message: e.toString()));
    }
  }
}
