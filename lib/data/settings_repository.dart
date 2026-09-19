import 'local_data_source.dart';

class SettingsRepository {
  final LocalDataSource localDataSource;

  SettingsRepository(this.localDataSource);

  Future<bool> getIsDark() async {
    return await localDataSource.getIsDark();
  }

  Future<void> saveIsDark(bool value) async {
    await localDataSource.saveIsDark(value);
  }
}
