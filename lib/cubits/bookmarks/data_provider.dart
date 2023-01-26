part of 'cubit.dart';

class BookmarksDataProvider {
  static final cache = Hive.box('data');

  static Future<List<Bookmark?>?> fetch({bool? lastRead}) async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <Bookmark?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<Bookmark?>? cachedBookmarks = List.from(
          bookmarks.where((element) => element.terakhirDibaca == lastRead));
      // final List<Bookmark?>? cachedBookmarks = List.from(bookmarks);
      return cachedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Bookmark?>?> addBookmark(Bookmark? bookmark) async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <Bookmark?>[];
        await cache.put('bookmarks', bookmarks);
      }

      List<Bookmark?>? updatedBookmarks = List.from(bookmarks);
      if (bookmark!.terakhirDibaca!) {
        updatedBookmarks = updatedBookmarks
            .where((element) => element!.terakhirDibaca == false)
            .toList();
      }
      List<Bookmark?> cek =
          updatedBookmarks.where((element) => element == bookmark).toList();
      if (cek.isEmpty) {
        updatedBookmarks.add(bookmark);
      }

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Bookmark?>?> removeBookmark(Bookmark? bookmark) async {
    try {
      final isLastReading = bookmark!.terakhirDibaca;
      List bookmarks = await cache.get('bookmarks');

      final List<Bookmark?>? updatedBookmarks = List.from(bookmarks);
      updatedBookmarks!.remove(bookmark);

      await cache.put('bookmarks', updatedBookmarks);
      final List<Bookmark?>? activeBookmark = List.from(updatedBookmarks
          .where((element) => element!.terakhirDibaca == isLastReading));
      return activeBookmark;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool?> checkBookmarked(Bookmark? bookmark) async {
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<Bookmark?>? updatedBookmarks = List.from(bookmarks);
      return updatedBookmarks!.contains(bookmark);
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
