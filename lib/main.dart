import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'cubit/notes_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/theme_state.dart';
import 'data/app_database.dart';
import 'data/notes_local_data_source.dart';
import 'data/notes_repository.dart';
import 'data/settings_local_data_source.dart';
import 'data/settings_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, AppDatabase? database})
      : database = database ?? AppDatabase();

  final appRouter = AppRouter();
  late final routerConfig = appRouter.config();
  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NotesRepository(NotesLocalDataSource(database)),
        ),
        RepositoryProvider(
          create: (context) => SettingsRepository(SettingsLocalDataSource()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotesCubit(context.read<NotesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ThemeCubit(context.read<SettingsRepository>())..loadTheme(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Заметки',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.indigo,
                  brightness: Brightness.light,
                ),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.indigo,
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
              ),
              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: routerConfig,
            );
          },
        ),
      ),
    );
  }
}
