part of 'cubit.dart';

class JuzIdDataProvider {
  static final cache = Hive.box('data');
  static Dio ins = Dio();

  static Future<JuzId?> juzFetchApi(num juzNumber) async {
    try {
      final resp = await ins.get(
        'http://api.alquran.cloud/v1/juz/$juzNumber/id.indonesian',
      );
      final Map<String, dynamic> raw = resp.data['data'];
      final JuzId juz = JuzId.fromMap(raw);

      await cache.put(
        'juzId$juzNumber',
        juz,
      );

      return juz;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<JuzId?> juzFetchHive(num juzNumber) async {
    try {
      final data = await cache.get('juzId$juzNumber');
      if (data == null) return null;

      final JuzId? juz = data;
      return juz;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
