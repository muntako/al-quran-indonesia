part of 'cubit.dart';

class ChapterIdDataProvider {
  static final cache = Hive.box('data');

  static Dio ins = Dio();

  static Future<List<ChapterId?>?> chapterIdApi() async {
    try {
      final resp = await ins.get(
        'http://api.alquran.cloud/v1/quran/id.indonesian',
      );
      final Map<String, dynamic> raw = resp.data['data'];

      final List data = raw['surahs'];
      final List<ChapterId> chapterIds = List.generate(
        data.length,
        (index) => ChapterId.fromMap(data[index]),
      );
      await cache.put(
        'chapterIds',
        chapterIds,
      );

      return chapterIds;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw Exception('Problem with internet connection');
      } else {
        throw Exception('Problem on our side, Please try again');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ChapterId?>?> chapterIdHive() async {
    try {
      final chapterId = await cache.get('chapterIds');

      if (chapterId == null) return null;

      final List<ChapterId?>? chapterIds = List.from(chapterId);

      return chapterIds;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
