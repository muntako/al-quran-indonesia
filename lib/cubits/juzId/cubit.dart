import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:al_quran/models/juzId/juzId.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class JuzIdCubit extends Cubit<JuzIdState> {
  static JuzIdCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<JuzIdCubit>(context, listen: listen);

  JuzIdCubit() : super(JuzIdDefault());

  final repo = JuzIdRepository();

  Future<void> fetch(num JuzIdNumber) async {
    emit(const JuzIdFetchLoading());

    try {
      JuzId? cached = await repo.juzFetchHive(JuzIdNumber);
      if (cached == null) {
        JuzId? data = await repo.juzFetchApi(JuzIdNumber);
        emit(JuzIdFetchSuccess(data: data));
      } else {
        emit(JuzIdFetchSuccess(data: cached));
      }
    } catch (e) {
      emit(JuzIdFetchFailed(message: e.toString()));
    }
  }
}
