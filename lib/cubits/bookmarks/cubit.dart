import 'package:al_quran/models/bookmark/bookmark.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

part 'state.dart';
part 'data_provider.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  static BookmarkCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<BookmarkCubit>(context, listen: listen);

  BookmarkCubit() : super(BookmarkDefault());

  Future<void> fetch({bool lastRead = false}) async {
    emit(const BookmarkFetchLoading());
    try {
      List<Bookmark?>? data =
          await BookmarksDataProvider.fetch(lastRead: lastRead);

      emit(BookmarkFetchSuccess(data: data, isLastRead: lastRead));
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> updateBookmark(
      {Bookmark? bookmark, bool lastRead = false}) async {
    emit(const BookmarkFetchLoading());
    try {
      List<Bookmark?>? data = [];

      Bookmark book = bookmark!.copyWith(
          number: bookmark.number,
          juz: bookmark.juz,
          surah: bookmark.surah,
          numberInSurah: bookmark.numberInSurah,
          terakhirDibaca: lastRead);
      data = await BookmarksDataProvider.addBookmark(book);
      emit(
        BookmarkFetchSuccess(data: data, isLastRead: lastRead),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    emit(const BookmarkFetchLoading());
    try {
      List<Bookmark?>? data = [];
      data = await BookmarksDataProvider.removeBookmark(bookmark);
      emit(
        BookmarkFetchSuccess(data: data),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> checkBookmarked(Bookmark bookmark) async {
    emit(const BookmarkFetchLoading());
    try {
      final isLastRead = await BookmarksDataProvider.checkBookmarked(bookmark);
      final data = await BookmarksDataProvider.fetch();
      emit(
        BookmarkFetchSuccess(
          data: data,
          isLastRead: isLastRead ?? false,
        ),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }
}
