part of 'cubit.dart';

class ChapterIdRepository {
  Future<List<ChapterId?>?> chapterIdApi() =>
      ChapterIdDataProvider.chapterIdApi();

  Future<List<ChapterId?>?> chapterIdHive() =>
      ChapterIdDataProvider.chapterIdHive();
}
