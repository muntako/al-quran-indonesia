part of 'cubit.dart';

class SurahRepository {
  Future<List<Surah?>?> surahApi() => SurahDataProvider.surahApi();

  Future<List<Surah?>?> surahHive() => SurahDataProvider.surahHive();
}
