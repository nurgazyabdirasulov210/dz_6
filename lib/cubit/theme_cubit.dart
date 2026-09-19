import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/settings_repository.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SettingsRepository repository;

  ThemeCubit(this.repository) : super(const ThemeState(false));

  Future<void> loadTheme() async {
    final isDark = await repository.getIsDark();
    emit(ThemeState(isDark));
  }

  Future<void> toggleTheme(bool value) async {
    emit(ThemeState(value));
    await repository.saveIsDark(value);
  }
}
