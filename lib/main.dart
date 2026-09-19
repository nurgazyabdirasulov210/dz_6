import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'cubit/notes_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/theme_state.dart';
import 'data/local_data_source.dart';
import 'data/notes_repository.dart';
import 'data/settings_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();
  final localDataSource = LocalDataSource();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesCubit(NotesRepository(localDataSource)),
        ),
        BlocProvider(
          create: (context) =>
              ThemeCubit(SettingsRepository(localDataSource))..loadTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Заметки',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}
