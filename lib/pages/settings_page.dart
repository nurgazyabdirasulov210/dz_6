import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/notes_state.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/theme_state.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return SwitchListTile(
                    title: const Text('Тёмная тема'),
                    value: state.isDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
                    },
                  );
                },
              ),
              BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  int count = 0;
                  if (state is NotesLoaded) {
                    count = state.notes.length;
                  }
                  return ListTile(
                    title: const Text('Всего заметок'),
                    trailing: Text('$count'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
