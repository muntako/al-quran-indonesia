part of 'cubit.dart';

class JuzIdRepository {
  Future<JuzId?> juzFetchApi(num juzNumber) =>
      JuzIdDataProvider.juzFetchApi(juzNumber);

  Future<JuzId?> juzFetchHive(num juzNumber) =>
      JuzIdDataProvider.juzFetchHive(juzNumber);
}
