part of 'cubit.dart';

class SurahDataProvider {
  static final cache = Hive.box('data');

  static Dio ins = Dio();

  static Future<List<Surah?>?> surahApi() async {
    try {
      final resp = await ins.get(
        'https://equran.id/api/surat',
      );
      // final Map<String, dynamic> raw = resp.data;

      final List data = resp.data;
      final List<Surah> surahs = List.generate(
        data.length,
        (index) => Surah.fromMap(data[index]),
      );
      await cache.put(
        'surahs',
        surahs,
      );

      return surahs;
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

  static Future<List<Surah?>?> surahHive() async {
    try {
      final surah = await cache.get('surahs');

      if (surah == null) return null;

      final List<Surah?>? surahs = List.from(surah);

      return surahs;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
